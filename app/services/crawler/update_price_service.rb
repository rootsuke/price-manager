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

    # def update_product_price
    #   result = {}
    #   Anemone.crawl(@product_url, depth_limit: 0) do |anemone|
    #     anemone.on_every_page do |page|
    #       # parse by Nokogiri, after convert character_code into utf-8
    #       item = Nokogiri::HTML.parse(page.body.toutf8)

    #       # display_price
    #       result[:display_price] = item.xpath("//span[@id=\"priceblock_ourprice\"]").text.strip
    #       # current_price
    #       result[:current_price] = result[:display_price].delete("^0-9")
    #     end
    #   end
    #   result
    # end

    private

      def crawling_price_on_amazon(item, result)
        # display_price
        result[:display_price] = item.xpath("//span[@id=\"priceblock_ourprice\"]").text.strip
        # current_price
        result[:current_price] = result[:display_price].delete("^0-9")
        result
      end

  end
end
