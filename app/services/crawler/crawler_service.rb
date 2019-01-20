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

  end
end
