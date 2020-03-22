FactoryBot.define do
  factory :invoice_items, class: InvoiceItem do
    quantity { rand(1..20) }
    unit_price { rand(1..100) }
    item { nil }
    invoice { nil }
  end
end