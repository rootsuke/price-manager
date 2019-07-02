class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      flash[:success] = "商品を登録しました"
      redirect_to product_url(@product)
    else
      flash[:danger] = "商品の登録に失敗しました"
      redirect_to root_url
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_url
      flash[:danger] = "商品が見つかりませんでした"
    end
  end

  def update
    @product = Product.find(params[:id])
    crawler = Crawler::UpdatePriceService.new(product_url: @product.product_url, site_type: @product.site_type)
    prices = crawler.update_product_price
    unless @product.update_attributes(prices)
      flash.now[:danger] = "商品価格の更新に失敗しました"
      return
      render "show"
    end
    respond_to do |format|
      format.html {
        flash[:success] = "商品価格を更新しました"
        redirect_to @product
      }
      format.js
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "商品を削除しました"
    redirect_to user_path(current_user)
  end

  def update_all
    UpdatePriceWorker.perform_async(current_user.id)
    flash[:success] = "価格情報を更新中です。しばらくお待ち下さい。"
    redirect_to current_user
  end

  private

    def product_params
      params.permit(:name, :base_price, :current_price, :display_price, :image_url, :product_url, :site_type)
    end

    def correct_user
      @product = current_user.products.find_by(id: params[:id])
      if @product.nil?
        flash[:danger] = "商品の削除に失敗しました"
        redirect_to root_url
      end
    end
end
