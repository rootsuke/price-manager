FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "product#{n}"}
    base_price { 9999 }
    current_price { 9000 }
    display_price { "¥9,000" }
    product_url { "#" }
    image_url { "#" }
    site_type { "amazon" }
    user
  end
end
