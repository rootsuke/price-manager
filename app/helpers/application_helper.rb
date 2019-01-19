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
      content_tag(html_tag, "価格変動なし", class: "price-not-changed")
    end
  end
end
