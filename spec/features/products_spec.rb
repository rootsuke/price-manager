require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  let(:user) { create(:user) }

  feature "Delete a post" do
    let(:other_user) { create(:user, name: "other_user") }
    let!(:user_product) { create(:product, user: user) }

    context "correct_user" do
      scenario "delete successfully" do
        login_as(user, scope: :user)
        visit product_path(user_product.id)
        expect {
          click_link "削除"
        }.to change(user.products, :count).by(-1)
        expect(current_path).to eq user_path(user.id)
      end
    end

    context "wrong_user" do
      scenario "cannot see the delete link" do
        login_as(other_user, scope: :user)
        visit product_path(user_product.id)
        expect(page).not_to have_selector "a", text: "削除する"
      end
    end
  end
end
