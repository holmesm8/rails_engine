FactoryBot.define do
  factory :invoice, class: Invoice do
    status { "shipped" }
    customer
    merchant
  end
end