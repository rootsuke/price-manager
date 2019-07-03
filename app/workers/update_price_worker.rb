class UpdatePriceWorker
  include Sidekiq::Worker

  def perform(user_id, options = {})
    mailer = options['mailer'] ||= false
    broadcast = options['broadcast'] ||= false
    user = User.find(user_id)
    products = user.products.all
    return if products.empty?
    products.each do |product|
      crawler = Crawler::UpdatePriceService.new(product_url: product.product_url, site_type: product.site_type)
      prices = crawler.update_product_price
      next unless product.update_attributes(prices)
    end
    ActionCable.server.broadcast("notification_channel_#{user_id}", "商品価格を更新しました") if broadcast
    UserMailer.notify_price(user).deliver_now if mailer
  end
end
