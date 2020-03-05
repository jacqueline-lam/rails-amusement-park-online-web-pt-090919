class AttractionsController < ApplicationController
  before_action :find_attraction, only: [:show, :edit, :update]

  def new
    @attraction = Attraction.new
  end

  def create
    attraction = Attraction.new(attraction_params)
    if attraction.save
      redirect_to attraction_path(attraction)
    else
      #index
      redirect_to attractions_path 
    end
  end

  def index
    @attractions = Attraction.all
  end

  def show
    @ride = @attraction.rides.build(user_id: current_user.id)
  end
  
  def edit
  end

  def update
    @attraction.update(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      render :edit
    end
  end

  private 
  def find_attraction
    @attraction = Attraction.find_by_id(params[:id])
  end

  def attraction_params
    params.require("attraction").permit("name", "min_height", "happiness_rating", "nausea_rating", "tickets")
  end
end