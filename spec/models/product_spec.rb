require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) { create(:product) }

  it "is invalid without name" do
    product.name = nil
    product.valid?
    expect(product.errors[:name]).to include "can't be blank"
  end

  it "is invalid without base_price" do
    product.base_price = nil
    product.valid?
    expect(product.errors[:base_price]).to include "can't be blank"
  end

  it "is invalid without current_price" do
    product.current_price = nil
    product.valid?
    expect(product.errors[:current_price]).to include "can't be blank"
  end

  it "is invalid without display_price" do
    product.display_price = nil
    product.valid?
    expect(product.errors[:display_price]).to include "can't be blank"
  end

  it "is invalid without product_url" do
    product.product_url = nil
    product.valid?
    expect(product.errors[:product_url]).to include "can't be blank"
  end

  it "is invalid without site_type" do
    product.site_type = nil
    product.valid?
    expect(product.errors[:site_type]).to include "can't be blank"
  end
end
