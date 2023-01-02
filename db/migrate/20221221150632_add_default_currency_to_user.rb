class AddDefaultCurrencyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :default_currency, :string
  end
end
