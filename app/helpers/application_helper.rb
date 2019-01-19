module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = "")
    base_title = "Price Manager"
    return base_title if page_title.empty?

    "#{page_title} | #{base_title}"
  end

  def display_price_drop(product, html_tag: :p)
    price_drop = product.calc_price_drop

    if price_drop.zero?
      # 価格下落なし
      content_tag(html_tag, "価格変動なし")
    elsif price_drop < 0
      # 価格が下落
      content_tag(html_tag, "価格下落：#{price_drop} (登録時の価格：#{product.base_price})", class: "price-down")
    else
      # 価格が上昇
      content_tag(html_tag, "価格上昇：+#{price_drop} (登録時の価格：#{product.base_price})", class: "price-rised")
    end
  end
end
