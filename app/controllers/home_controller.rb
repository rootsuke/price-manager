class HomeController < ApplicationController
  def index
    if params[:product_url].present? && params[:site][:name].present?
      crawler = Crawler::CrawlerService.new(product_url: params[:product_url], site_type: params[:site][:name])
      @crawl_result = crawler.crawl
    end
  end

  def help
  end
end
