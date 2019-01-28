class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @products = @user.products.paginate(page: params[:page], per_page: 10)
  end
end
