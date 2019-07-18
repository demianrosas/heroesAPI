require 'rails_helper'

RSpec.describe 'Heroes API', type: :request do
  # initialize test data
  let!(:heroes) { create_list(:hero, 10) }
  let(:hero_id) { heroes.first.id }

  # Test suite for GET /heroes
  describe 'GET /heroes' do
    # make HTTP get request before each example
    before { get '/heroes' }

    it 'returns heroes' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /heroes/:id
  describe 'GET /heroes/:id' do
    before { get "/heroes/#{hero_id}" }

    context 'when the record exists' do
      it 'returns the hero' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(hero_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:hero_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Hero/)
      end
    end
  end

  # Test suite for POST /heroes
  describe 'POST /heroes' do
    # valid payload
    let(:valid_attributes) { { name: 'Ironman', superpower: 'Inteligence', company: 'Marvel', alignment: 'Lawful' } }

    context 'when the request is valid' do
      before { post '/heroes', params: valid_attributes }

      it 'creates a hero' do
        expect(json['name']).to eq('Ironman')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/heroes', params: { name: 'Ironman' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Superpower can't be blank, Company can't be blank, Alignment can't be blank/)
      end
    end
  end

  # Test suite for PUT /heroes/:id
  describe 'PUT /heroes/:id' do
    let(:valid_attributes) { { name: 'Thor' } }

    context 'when the record exists' do
      before { put "/heroes/#{hero_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /heroes/:id
  describe 'DELETE /heroes/:id' do
    before { delete "/heroes/#{hero_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
