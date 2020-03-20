class Api::V1::Merchants::FindController < ApplicationController
  def show
    if find_params[:name]
      attribute = find_params.keys.first
      render json: MerchantSerializer.new(Merchant.where("lower(#{attribute}) = ?", find_params[attribute.to_sym].downcase))
    else
      render json: MerchantSerializer.new(Merchant.where(find_params))
    end
  end

  private

    def find_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end