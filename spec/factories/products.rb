FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "product#{n}"}
    base_price { 9999 }
    current_price { 9000 }
    display_price { "¥9,000" }
    product_url { "http://sample_product.example.com" }
    image_url { "http://sample_image.example.com" }
    site_type { "amazon" }
    user
  end
end
