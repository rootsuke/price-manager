class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :base_price
      t.integer :current_price
      t.string :display_price
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :products, [:user_id, :created_at]
  end
end
