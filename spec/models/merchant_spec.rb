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
      @invoice2 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant2.id, created_at: "2020-03-16")
      @invoice3 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant3.id, created_at: "2020-03-16")
      @invoice4 = create(:invoice, customer_id: @customer1.id, merchant_id: @merchant4.id, created_at: "2020-03-16")

      @invoice_items1 = create(:invoice_items, item_id: @item1.id, quantity: 1, unit_price: 1, invoice_id: @invoice1.id, created_at: "2012-03-16")
      @invoice_items2 = create(:invoice_items, item_id: @item2.id, quantity: 2, unit_price: 2, invoice_id: @invoice2.id)
      @invoice_items3 = create(:invoice_items, item_id: @item3.id, quantity: 3, unit_price: 3, invoice_id: @invoice3.id)
      @invoice_items4 = create(:invoice_items, item_id: @item4.id, quantity: 4, unit_price: 4, invoice_id: @invoice4.id)

      @transaction1 = create(:transaction, invoice_id: @invoice1.id, created_at: "2012-03-16")
      @transaction2 = create(:transaction, invoice_id: @invoice2.id)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id)
      @transaction4 = create(:transaction, invoice_id: @invoice4.id)
    end
      
    it "#merchants_with_most_revenue(quantity)" do
      expected_results = [@merchant4, @merchant3, @merchant2]

      expect(Merchant.merchants_with_most_revenue(3)).to eq(expected_results)
    end

    it "#merchant_revenue" do
      expected_results = 1

      expect(Merchant.merchant_revenue(@merchant1.id)).to eq(expected_results)
    end

    it "#total_revenue_by_date_range" do
      start_date = "2012-03-15"
      end_date = "2013-12-01"

      expected_results = 1

      expect(Merchant.total_revenue_by_date_range(start_date.to_date, end_date.to_date)).to eq(1)
    end

    it "#merchants_with_most_items_sold" do
      expected_results = [@merchant4, @merchant3]

      expect(Merchant.merchants_with_most_items_sold(2)).to eq(expected_results)
    end
  end
end

