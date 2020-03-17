class InvoiceItem < ApplicationRecord 
  validates_presence_of :quantity
  validates_presence_of :unit_price

end