class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    # plant = find_plant
    # render json: plant
    # find_plant
    render json: find_plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # PATCH /plants/:id

  def update 
    find_plant.update(plant_params)
    render json: find_plant
  end

  def add_is_in_stock_to_plants
    plant = find_plant
    plant.update(is_in_stock: false)
  end

  def destroy
      find_plant.destroy
      head :no_content
  end

  private
  def find_plant
    Plant.find(params[:id])
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
  
  def render_not_found_response
    render json: { error: "Plant not found" }, status: :not_found
  end

end
