require 'rails_helper'

RSpec.feature "Users", type: :feature do
  given(:user)       { create(:user) }
  given(:other_user) { create(:user, name: "other_user") }

  given!(:user_products) { create_list(:product, 3, user: user) }
  given!(:other_product) { create(:product, user: other_user) }

  background do
    login_as(user, scope: :user)
    visit user_path user.id
  end

  scenario "render user_detail_page" do
    expect(current_path).to eq user_path(user.id)
    expect(page).to have_title("#{user.name} | Price Manager")
    within "#user_info" do
      expect(page).to have_content(user.name)
    end
    within "#products_count" do
      expect(page).to have_content(3)
    end
    user.products.all.each do |product|
      expect(page).to have_content(product.name)
    end
    expect(page).not_to have_content(other_product.name)
    click_link user.products.first.name
    expect(current_path).to eq product_path(user.products.first.id)
  end

  feature "Edit user_profile" do
    background do
      login_as(user, scope: :user)
      click_link "ユーザー情報を編集する"
    end

    context "valid params" do
      scenario "edit successfully" do
        expect(current_path).to eq edit_user_registration_path(user.id)
        fill_in "Name", with: "New Name"
        fill_in "Current password", with: "password"
        click_button "編集する"
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content "Your account has been updated successfully."
        within "#user_info" do
          expect(page).to have_content("New Name")
        end
      end
    end

    context "invalid params" do
      scenario "fail to edit" do
        fill_in "Name", with: ""
        fill_in "Current password", with: "wrongpass"
        click_button "編集する"
        expect(page).to have_content "2 errors"
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Current password is invalid"
      end
    end
  end
end
