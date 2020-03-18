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

  it "can get an item by id" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(item1.id)
  end

  it "can create a new item" do
    merchant1 = create(:merchant)
    item_params = { name: "Super Mario World 88", description: "Simulator", unit_price: 20, merchant_id: merchant1.id}

    post "/api/v1/items", params: {item: item_params}
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it "can update an existing item" do
    merchant1 = create(:merchant)
    id = create(:item, merchant_id: merchant1.id).id
    previous_name = Item.last.name
    item_params = { name: "Tetris" }

    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Tetris")
  end

  it "can destroy an item" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    expect{ delete "/api/v1/items/#{item1.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end