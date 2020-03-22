class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.merchants_with_most_revenue(params[:quantity]))
  end

  def show
    revenue = Merchant.merchant_revenue(params[:id].to_i)
    render json: {data: {id: params[:id].to_i, attributes: {revenue: revenue}}}
  end
  
  private

    def find_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end