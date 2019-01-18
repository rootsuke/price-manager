require 'kconv'

module Crawler
  class CrawlerService
    def initialize(url: "", site_type: "")
      @url = url
      @site_type = site_type
    end

    def crawl
      result = {}
      Anemone.crawl(@url, depth_limit: 0) do |anemone|
        anemone.on_every_page do |page|
          # parse by Nokogiri, after convert character_code into utf-8
          item = Nokogiri::HTML.parse(page.body.toutf8)

          # name
          result[:name] = item.xpath("//span[@id=\"productTitle\"]").text.strip
          # current_price
          result[:current_price] = item.xpath("//span[@id=\"priceblock_ourprice\"]").text.strip.delete("^0-9")
          # display_price
          result[:display_price] = item.xpath("//span[@id=\"priceblock_ourprice\"]").text.strip
          # image_url
          result[:image_url] = item.xpath("//img[@id=\"landingImage\"]").attribute("data-old-hires").text.strip
        end
      end
      result
    end
  end
end
