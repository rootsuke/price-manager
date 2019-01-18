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

  def destroy
    @product.destroy
    flash[:success] = "商品を削除しました"
    redirect_to user_path(current_user)
  end

  private

    def product_params
      params.permit(:name, :base_price, :current_price, :display_price, :image_url)
    end

    def correct_user
      @product = current_user.products.find_by(id: params[:id])
      if @product.nil?
        flash[:danger] = "商品の削除に失敗しました"
        redirect_to root_url
      end
    end
end
