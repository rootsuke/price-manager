require 'kconv'

module Crawler
  class UpdatePriceService
    def initialize(product_url: "", site_type: "")
      @product_url = product_url
      @site_type = site_type
    end

    def update_product_price
      result = {}
      Anemone.crawl(@product_url, depth_limit: 0) do |anemone|
        anemone.on_every_page do |page|
          # parse by Nokogiri, after convert character_code into utf-8
          item = Nokogiri::HTML.parse(page.body.toutf8)

          result = send("crawling_price_on_#{@site_type}", item, result)
        end
      end
      result
    end

    private

      def crawling_price_on_amazon(item, result)
        # display_price
        result[:display_price] = item.xpath("//span[@id=\"priceblock_ourprice\"]").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9")
        result
      end

      def crawling_price_on_amazon_book(item, result)
        # display_price
        # 価格取得ロジックが不完全
        # 価格が取得できずnilになることがある
        # APIを利用しなければ正確な価格の取得は難しい
        result[:display_price] = item.xpath("//span[@class=\"a-color-price\"]").text.match(%r{¥{1}[\d,]+}).to_s
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9")
        result
      end

      def crawling_price_on_zozo(item, result)
        # display_price
        result[:display_price] = item.xpath("//div[@id='isLaterPay']/div/div[@class='goods-price']").text.strip
        if result[:display_price].blank?
          result[:display_price] = item.xpath("//div[@id='isLaterPay']/div/div[@class='goods-price discount-price']").text.strip
        end
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9", "^\.")
        result
      end

      def crawling_price_on_wiggle(item, result)
        # display_price
        result[:display_price] = item.xpath("//div[@class='bem-pricing']/p").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9", "^\.")
        result
      end

      def crawling_price_on_bellati(item, result)
        # display_price
        result[:display_price] = item.xpath("//span[@class='tr yprice']").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9", "^\.")
        result
      end

  end
end
