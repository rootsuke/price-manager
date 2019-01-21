require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:oldest_product) { create(:product, created_at: 2.days.ago,   user: user) }
  let(:old_product)    { create(:product, created_at: 1.day.ago,    user: user) }
  let(:new_product)    { create(:product, created_at: DateTime.now, user: user) }

  describe "GET #show" do
    login_user

    before do
      get :show, params: { id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render show page" do
      expect(response).to render_template(:show)
    end

    it "assigns @user" do
      expect(assigns(:user)).to eq user
    end

    it "assigns @posts" do
      expect(assigns(:products)).to eq [oldest_product, old_product, new_product]
    end
  end
end
