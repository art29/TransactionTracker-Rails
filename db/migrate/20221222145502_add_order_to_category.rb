class AddOrderToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :order, :integer, null: false
  end
end
