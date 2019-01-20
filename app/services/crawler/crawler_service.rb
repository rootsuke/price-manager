require 'kconv'

module Crawler
  class CrawlerService
    def initialize(product_url: "", site_type: "")
      @product_url = product_url
      @site_type = site_type
    end

    def crawl
      result = {}
      Anemone.crawl(@product_url, depth_limit: 0) do |anemone|
        anemone.on_every_page do |page|
          # parse by Nokogiri, after convert character_code into utf-8
          item = Nokogiri::HTML.parse(page.body.toutf8)

          result = send("crawl_on_#{@site_type}", item, result)
        end
      end
      result
    end

    private

      def crawl_on_amazon(item, result)
        # name
        result[:name] = item.xpath("//span[@id=\"productTitle\"]").text.strip
        # display_price
        result[:display_price] = item.xpath("//span[@id=\"priceblock_ourprice\"]").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9")
        # image_url
        result[:image_url] = item.xpath("//img[@id=\"landingImage\"]").attribute("data-old-hires").text.strip
        result
      end

      def crawl_on_amazon_book(item, result)
        # name
        result[:name] = item.xpath("//span[@id=\"productTitle\"]").text.strip
        # display_price
        # 価格取得ロジックが不完全
        # 価格が取得できずnilになることがある
        # APIを利用しなければ正確な価格の取得は難しい
        result[:display_price] = item.xpath("//span[@class=\"a-color-price\"]").text.match(%r{¥{1}[\d,]+}).to_s
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9")
        # image_url
        result[:image_url] = item.xpath("//img[@id=\"imgBlkFront\"]").attribute("data-a-dynamic-image").text.strip.match(%r{http.+?jpg})
        result
      end

      def crawl_on_zozo(item, result)
        # name
        result[:name] = item.xpath("//div[@id=\"item-intro\"]/h1").text.strip
        # display_price
        result[:display_price] = item.xpath("//div[@id='isLaterPay']/div/div[@class='goods-price']").text.strip
        if result[:display_price].blank?
          result[:display_price] = item.xpath("//div[@id='isLaterPay']/div/div[@class='goods-price discount-price']").text.strip
        end
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9")
        # image_url
        result[:image_url] = item.xpath("//div[@id=\"photoMain\"]/img").attribute("src").text.strip
        result
      end

      def crawl_on_wiggle(item, result)
        # name
        result[:name] = item.xpath("//h1[@id='productTitle']").text.strip
        # display_price
        result[:display_price] = item.xpath("//div[@class='bem-pricing']/p").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9", "^\.")
        # image_url
        result[:image_url] = item.xpath("//img[@id='pdpGalleryImage']").attribute("src").text.strip
        result
      end

      def crawl_on_bellati(item, result)
        # name
        result[:name] = item.xpath("//div[@class='title']/h1").text.strip
        # display_price
        result[:display_price] = item.xpath("//span[@class='tr yprice']").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9", "^\.")
        # image_url
        image_url = item.xpath("//div[@id='prodimg']/img").attribute("src").text.strip
        result[:image_url] = "https://www.bellatisport.com#{image_url}"
        result
      end
  end
end
