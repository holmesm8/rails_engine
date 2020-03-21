class Api::V1::Items::FindController < ApplicationController
  def index
    if find_params[:name] 
      render json: ItemSerializer.new(Item.where('name ILIKE ?', "%#{find_params[:name]}%"))
    else
      render json: ItemSerializer.new(Item.where('description ILIKE ?', "%#{find_params[:description]}%"))
    end
  end

  def show
    if find_params[:name] || find_params[:description]
      render json: ItemSerializer.new(Item.where(request.query_parameters))
    else
      render json: ItemSerializer.new(Item.where(find_params))
    end
  end

  private

    def find_params
      params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
    end
end