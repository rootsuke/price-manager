class AddUrlAndSiteToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :product_url, :string
    add_column :products, :site_type, :string
  end
end
