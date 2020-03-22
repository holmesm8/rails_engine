FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { Faker::Finance.credit_card(:mastercard).delete('-') }
    credit_card_expiration_date { nil }
    result { "success" }
    invoice { nil }
  end
end