class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :update, :destroy]
  before_action :set_hero, only: :index

  # GET /missions
  def index
    @missions = @hero.missions
    json_response(@missions)
  end

  # POST /missions
  def create
    @mission = Mission.create!(mission_params)
    json_response(@mission, :created)
  end

  # GET /missions/:id
  def show
    json_response(@mission)
  end

  # PUT /missions/:id
  def update
    @mission.update(mission_params)

    head :no_content
  end

  # DELETE /missions/:id
  def destroy
    @mission.destroy
    head :no_content
  end

  private

  def mission_params
    # whitelist params
    params.permit(:description, :date, :status, :place, :hero_id)
  end

  def set_hero
    @hero = Hero.find(params[:hero_id])
  end

  def set_mission
    @mission = Mission.find(params[:id])
  end
end
