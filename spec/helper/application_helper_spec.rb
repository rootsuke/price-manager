require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "returns base_title" do
      expect(full_title).to eq("Price Manager")
    end

    it "returns page_title and base_title" do
      expect(full_title("Page_title")).to eq("Page_title | Price Manager")
    end
  end

  describe "#display_price_drop" do
    let(:product) { create(:product) }

    context "price not changed" do
      it "returns price_drop_value correctly" do
        product.current_price = 9999
        expect(display_price_drop(product)).to eq content_tag(:p, "価格変動なし")
      end
    end

    context "price dropped" do
      it "returns price_drop_value correctly" do
        product.current_price = 9000
        expect(display_price_drop(product)).to eq content_tag(:p, "価格下落：-999 (登録時の価格：#{product.base_price})", class: "price-down")
      end
    end

    context "price rised" do
      it "returns price_drop_value correctly" do
        product.current_price = 19999
        expect(display_price_drop(product)).to eq content_tag(:p, "価格上昇：+10000 (登録時の価格：#{product.base_price})", class: "price-rised")
      end
    end
  end
end
