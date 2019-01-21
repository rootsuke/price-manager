require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render index page" do
      expect(response).to render_template(:index)
    end
  end
end
