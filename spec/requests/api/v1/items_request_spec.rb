require 'rails_helper'

describe "Items API" do 
  it "sends a list of items" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it "sends a list of items" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item[:id]).to eq(id)
  end

end