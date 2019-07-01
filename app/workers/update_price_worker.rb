class UpdatePriceWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    products = user.products.all
    return if products.empty?
    products.each do |product|
      crawler = Crawler::UpdatePriceService.new(product_url: product.product_url, site_type: product.site_type)
      prices = crawler.update_product_price
      product.update_attributes(prices)
      next unless product.save
    end
    UserMailer.notify_price(user).deliver_now
  end
end
