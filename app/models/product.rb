class Product < ApplicationRecord
  belongs_to :user

  validates :name,          presence: true
  validates :base_price,    presence: true
  validates :current_price, presence: true
  validates :display_price, presence: true
  validates :product_url,   presence: true
  validates :site_type,     presence: true

  def calc_price_drop
    current_price - base_price
  end
end
