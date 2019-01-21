require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user)           { create(:user) }
  let!(:user_product)  { create(:product, user: user) }
  let(:other_user)     { create(:user,    name: "other_user") }
  let!(:other_product) { create(:product, name: "other_product", user: other_user) }

  describe "GET #show" do
    login_user

    before do
      get :show, params: { id: user_product.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render new page" do
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "by login_user" do
      login_user

      it "create a product successfully" do
        params = attributes_for(:product)
        expect {
          post :create, params: params
        }.to change(user.products, :count).by(1)
      end
    end

    context "by not_login_user" do
      it "fail to create a product" do
        params = attributes_for(:product)
        expect {
          post :create, params: params
        }.to change(user.products, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    context "by correct_user" do
      login_user

      it "delete the product successfully" do
        expect {
          delete :destroy, params: { id: user_product.id }
        }.to change(user.products, :count).by(-1)
      end
    end

    context "by wrong_user" do
      login_user

      it "fail to delete the product" do
        expect {
          delete :destroy, params: { id: other_product.id }
        }.to change(other_user.products, :count).by(0)
      end
    end
  end
end
