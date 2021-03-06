class UpdateAllProductPriceJob < ApplicationJob
  queue_as :update_price

  def perform(user)
    products = user.products.all
    return if products.empty?
    products.each do |product|
      crawler = Crawler::UpdatePriceService.new(product_url: product.product_url, site_type: product.site_type)
      prices = crawler.update_product_price
      product.update_attributes(prices)
      unless product.save
        next
      end
    end
  end
end
