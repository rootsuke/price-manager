class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :base_price, presence: true
  validates :display_price, presence: true
end
