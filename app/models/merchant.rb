class Merchant < ApplicationRecord 
  validates_presence_of :name 

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.merchants_with_most_revenue(quantity)
    joins(:transactions, :invoice_items)
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group(:id).order('revenue DESC')
    .limit(quantity.to_i)
    # .where("transactions.result = 'success'")
  end

  def self.merchant_revenue(merchant_id)
    (joins(:transactions, :invoice_items)
    .where("transactions.result = 'success' AND merchants.id = #{merchant_id}")
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group(:id)).first.revenue
  end

  def self.total_revenue_by_date_range(start_date, end_date)
    merchants = (joins(:invoice_items, :transactions)
    .where(created_at: start_date..end_date, transactions: {result: "success"})
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group(:id))
    merchants.sum(&:revenue)
  end

  def self.merchants_with_most_items_sold(quantity)
    joins(:transactions, :invoice_items)
    .where("transactions.result = 'success'")
    .select('merchants.*, sum(invoice_items.quantity) AS sold')
    .group(:id).order('sold DESC')
    .limit(quantity.to_i)
  end
end