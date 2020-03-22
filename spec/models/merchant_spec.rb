require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :name }
  end 
  describe 'relationships' do 
    it { should have_many :items }
    it { should have_many :invoices }
    # it { should have_many().through() }
  end 

  describe 'methods' do
    before(:each) do 
      @customer1 = create(:customer)

      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @merchant4 = create(:merchant)

      @item1 = create(:item, unit_price: 1, merchant_id: @merchant1.id)
      @item2 = create(:item, unit_price: 2, merchant_id: @merchant2.id)
      @item3 = create(:item, unit_price: 3, merchant_id: @merchant3.id)
      @item4 = create(:item, unit_price: 4, merchant_id: @merchant4.id)

      @invoice1 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant1.id)
      @invoice2 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant2.id)
      @invoice3 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant3.id)
      @invoice4 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant4.id)

      @invoice_items1 = create(:invoice_items, item_id: @item1.id, quantity: 1, unit_price: 1, invoice_id: @invoice1.id)
      @invoice_items2 = create(:invoice_items, item_id: @item2.id, quantity: 1, unit_price: 2, invoice_id: @invoice2.id)
      @invoice_items3 = create(:invoice_items, item_id: @item3.id, quantity: 1, unit_price: 3, invoice_id: @invoice3.id)
      @invoice_items4 = create(:invoice_items, item_id: @item4.id, quantity: 1, unit_price: 4, invoice_id: @invoice4.id)

      @transaction1 = create(:transaction, invoice_id: @invoice1.id)
      @transaction2 = create(:transaction, invoice_id: @invoice2.id)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id)
      @transaction4 = create(:transaction, invoice_id: @invoice4.id)
    end
      
    it "#merchant_revenue" do
      expected_results = [@merchant4, @merchant3, @merchant2]

      expect(Merchant.merchants_with_most_revenue(3)).to eq(expected_results)
    end
  end
end