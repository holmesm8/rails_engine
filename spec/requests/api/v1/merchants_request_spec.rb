require 'rails_helper'

describe "Merchants API" do 
  it "sends a list of merchants" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(3)
  end

  it "can get a merchant by id" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/#{merchant1.id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant[:id]).to eq(merchant1.id.to_s)
  end

  it "can create a new merchant" do
    merchant_params = { name: "Matt's Store" }

    post "/api/v1/merchants", params: merchant_params
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    merchant1 = create(:merchant)
    id = merchant1.id
    previous_name = Merchant.last.name
    merchant_params = { name: "Matt's Store" }

    put "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Matt's Store")
  end

  it "can destroy an merchant" do
    merchant1 = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant1.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_success
    expect{Merchant.find(merchant1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can display all items belonging to a specific merchant" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)
    item4 = create(:item, merchant_id: merchant1.id)
    item5 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(response).to be_success
    expect(items.count).to eq(5)
  end

  it "can return a single record that matches a name" do
    merchant1 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant[0]["attributes"]["name"]).to eq(merchant1.name)
  end

  it "can return a single record that matches an id" do
    merchant1 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant1.id}"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant[0]["attributes"]["id"]).to eq(merchant1.id)
  end

    it "can return a single record that matches a created at" do
    merchant1 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"
    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant[0]["attributes"]["id"]).to eq(merchant1.id)
  end

    it "can return a single record that matches a updated at" do
    merchant1 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant1.updated_at}"
    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant[0]["attributes"]["id"]).to eq(merchant1.id)
  end
end