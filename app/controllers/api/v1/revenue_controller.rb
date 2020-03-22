class Api::V1::RevenueController < ApplicationController
  def show
    render json: {data: {id: params[:id].to_i, attributes: {revenue: total_revenue}}}
  end
  
  private

    def find_params
      params.permit(:id, :name, :created_at, :updated_at)
    end

  def total_revenue
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    revenue = Merchant.total_revenue_by_date_range(params[:start], params[:end])
  end
end