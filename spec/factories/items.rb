FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Game.title }
    description { Faker::Game.genre }
    unit_price { rand(1..100) }
    merchant { nil }
  end
end