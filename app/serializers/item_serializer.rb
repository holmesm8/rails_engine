class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |item|
    item.unit_price_converter
  end
  
  belongs_to :merchant
end
