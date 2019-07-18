require 'rails_helper'

RSpec.describe 'Missions API' do
  # Initialize the test data
  let!(:hero) { create(:hero) }
  let!(:missions) { create_list(:mission, 20, hero_id: hero.id) }
  let(:hero_id) { hero.id }
  let(:id) { missions.first.id }

  # Test suite for GET /heroes/:hero_id/missions
  describe 'GET /heroes/:hero_id/missions' do
    before { get "/heroes/#{hero_id}/missions" }

    context 'when hero exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all hero missions' do
        expect(json.size).to eq(20)
      end
    end

    context 'when hero does not exist' do
      let(:hero_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Hero/)
      end
    end
  end

  # Test suite for GET /heroes/:hero_id/missions/:id
  describe 'GET /heroes/:hero_id/missions/:id' do
    before { get "/heroes/#{hero_id}/missions/#{id}" }

    context 'when hero mission exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the mission' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when hero mission does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Mission/)
      end
    end
  end

  # Test suite for PUT /heroes/:hero_id/missions
  describe 'POST /heroes/:hero_id/missions' do
    let(:valid_attributes) { { description: 'Defend NY', place: 'NY', date: '2019-07-01', status: 'in progress' } }

    context 'when request attributes are valid' do
      before { post "/heroes/#{hero_id}/missions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/heroes/#{hero_id}/missions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Validation failed: Description can't be blank, Place can't be blank, Date can't be blank/)
      end
    end
  end

  # Test suite for PUT /heroes/:hero_id/missions/:id
  describe 'PUT /heroes/:hero_id/missions/:id' do
    let(:valid_attributes) { { description: 'Defend SB' } }

    before { put "/heroes/#{hero_id}/missions/#{id}", params: valid_attributes }

    context 'when mission exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the mission' do
        updated_mission = Mission.find(id)
        expect(updated_mission.description).to match(/Defend SB/)
      end
    end

    context 'when the mission does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Mission/)
      end
    end
  end

  # Test suite for DELETE /heroes/:id
  describe 'DELETE /heroes/:id' do
    before { delete "/heroes/#{hero_id}/missions/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
