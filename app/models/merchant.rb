class Merchant < ApplicationRecord 
  validates_presence_of :name 

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.merchants_with_most_revenue(quantity)
    joins(:transactions, :invoice_items)
    .where("transactions.result = 'success'")
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group(:id).order('revenue DESC, name')
    .limit(quantity.to_i)
  end

  def self.merchant_revenue(merchant_id)
    (joins(:transactions, :invoice_items)
    .where("transactions.result = 'success' AND merchants.id = #{merchant_id}")
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group(:id)).first.revenue
  end
end