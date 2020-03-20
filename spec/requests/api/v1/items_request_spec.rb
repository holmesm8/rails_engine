require 'rails_helper'

describe "Items API" do 
  it "sends a list of items" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(3)
  end

  it "can get an item by id" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(item[:id]).to eq(item1.id.to_s)
  end

  it "can create a new item" do
    merchant1 = create(:merchant)
    item_params = { name: "Super Mario World 88", description: "Simulator", unit_price: 20, merchant_id: merchant1.id}

    post "/api/v1/items", params: item_params
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it "can update an existing item" do
    merchant1 = create(:merchant)
    id = create(:item, merchant_id: merchant1.id).id
    previous_name = Item.last.name
    item_params = { name: "Tetris" }

    put "/api/v1/items/#{id}", params: item_params
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

  it "can show the merchant the item belongs to" do
    merchant1 = create(:merchant)
    item_params = { name: "Testy Game", description: "Simulator", unit_price: 100, merchant_id: merchant1.id}

    post "/api/v1/items", params: item_params
    item = Item.last

    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant[:attributes][:id]).to eq(merchant1.id)
  end

  it "can return a single record that matches a name" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/find?name=#{item1.name}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item[0]["attributes"]["name"]).to eq(item1.name)
  end

  it "can return a single record that matches a name" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/find?description=#{item1.description}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item[0]["attributes"]["description"]).to eq(item1.description)
  end

  it "can return a single record that matches a unit price" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/find?unit_price=#{item1.unit_price}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item[0]["attributes"]["unit_price"]).to eq(item1.unit_price)
  end

  it "can return a single record that matches a merchant_id" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/find?merchant_id=#{item1.merchant_id}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item[0]["attributes"]["merchant_id"]).to eq(item1.merchant_id)

    item2 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/find?merchant_id=#{item1.merchant_id}"
    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item[0]["attributes"]["merchant_id"]).to eq(item2.merchant_id)
  end

  # it "can return a single record that matches a created at" do
  #   merchant1 = create(:merchant)
  #   item1 = create(:item, merchant_id: merchant1.id)

  #   get "/api/v1/items/find?unit_price=#{item1.created_at}"
  #   item = JSON.parse(response.body)["data"]
  #   require 'pry'; binding.pry

  #   expect(response).to be_successful
  #   expect(item[0]["attributes"]["unit_price"]).to eq(item1.unit_price)
  # end


end