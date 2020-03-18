class Item < ApplicationRecord 
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def unit_price_converter
    unit_price / 100.to_f
  end
end