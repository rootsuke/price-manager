class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :base_price, presence: true
  validates :display_price, presence: true

  def calc_price_drop
    base_price - current_price
  end
end
