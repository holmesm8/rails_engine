require 'rails_helper'

RSpec.describe Item, type: :model do 

  describe 'validations' do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :description } 
    it { should validate_presence_of :unit_price }
  end 

  describe 'relationships' do 
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end 

  describe 'methods' do
    it "can convert unit_price to two decimal places" do
      merchant1 = create(:merchant)
      item1 = Item.new(name: "Banana", description: "Ripe", unit_price: 50, merchant_id: merchant1.id)

      expect(item1.unit_price_converter).to eq(0.5)
    end
  end
end