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

    post "/api/v1/merchants", params: {merchant: merchant_params}
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    merchant1 = create(:merchant)
    id = merchant1.id
    previous_name = Merchant.last.name
    merchant_params = { name: "Matt's Store" }

    put "/api/v1/merchants/#{id}", params: {merchant: merchant_params}
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
end