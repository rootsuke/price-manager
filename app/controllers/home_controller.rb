class HomeController < ApplicationController
  def index
  end

  def help
  end

  def crawl
    if params[:product_url].present? && params[:site][:name].present?
      crawler = Crawler::CrawlerService.new(product_url: params[:product_url], site_type: params[:site][:name])
      @crawl_result = crawler.crawl
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end
  end
end
