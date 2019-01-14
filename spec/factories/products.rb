FactoryBot.define do
  factory :product do
    name { "MyString" }
    base_price { 1 }
    current_price { 1 }
    display_price { "MyString" }
    user { nil }
  end
end
