require 'rails_helper'

describe "Merchants Business Intelligence" do 
  before(:each) do 
    @customer1 = create(:customer, created_at: "2012-03-16")

    @merchant1 = create(:merchant, created_at: "2012-03-16")
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)

    @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id, created_at: "2012-03-16")
    @item2 = create(:item, unit_price: 2, merchant_id: @merchant2.id)
    @item3 = create(:item, unit_price: 3, merchant_id: @merchant3.id)
    @item4 = create(:item, unit_price: 4, merchant_id: @merchant4.id)

    @invoice1 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant1.id, created_at: "2012-03-16")
    @invoice2 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant2.id)
    @invoice3 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant3.id)
    @invoice4 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant4.id)

    @invoice_items1 = create(:invoice_items, item_id: @item1.id, quantity: 1, unit_price: 1, invoice_id: @invoice1.id, created_at: "2012-03-16")
    @invoice_items2 = create(:invoice_items, item_id: @item2.id, quantity: 2, unit_price: 2, invoice_id: @invoice2.id)
    @invoice_items3 = create(:invoice_items, item_id: @item3.id, quantity: 3, unit_price: 3, invoice_id: @invoice3.id)
    @invoice_items4 = create(:invoice_items, item_id: @item4.id, quantity: 4, unit_price: 4, invoice_id: @invoice4.id)

    @transaction1 = create(:transaction, invoice_id: @invoice1.id, created_at: "2012-03-16")
    @transaction2 = create(:transaction, invoice_id: @invoice2.id)
    @transaction3 = create(:transaction, invoice_id: @invoice3.id)
    @transaction4 = create(:transaction, invoice_id: @invoice4.id)
  end
  
  it "returns a list of merchants with the most revenue" do
    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(3)
  end

  it "returns the total revenue of a single merchant" do
    get "/api/v1/merchants/#{@merchant1.id}/revenue"

    expect(response).to be_successful

    merchant_revenue = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant_revenue[:attributes][:revenue]).to eq(1)
  end

  it "returns the total revenue across date range" do
    get "/api/v1/revenue?start=2012-03-09&end=2012-03-24"

    expect(response).to be_successful
    
    merchant_revenue = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant_revenue[:attributes][:revenue].to_f.round(2)).to eq(1)
  end

  it "returns a list of merchants with the most items sold" do
    expected_results = [@merchant4, @merchant3]
    get "/api/v1/merchants/most_items?quantity=2"

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    
    merchant_revenue = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchant_revenue.count).to eq(expected_results.count)
  end
end