class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i(twitter google)

  has_many :products, dependent: :destroy

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def update_all_product
    products.each do |product|
      crawler = Crawler::UpdatePriceService.new(product_url: product.product_url, site_type: product.site_type)
      prices = crawler.update_product_price
      product.update_attributes(prices)
      unless product.save
        puts "#{name} : #{product.name}更新失敗"
        next
      end
    end
  end
end
