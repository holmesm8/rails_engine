class Api::V1::Merchants::SoldItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.merchants_with_most_items_sold(params[:quantity]))
  end
end