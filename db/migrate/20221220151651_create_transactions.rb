class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.date :date
      t.numeric :original_price
      t.string :original_currency
      t.numeric :final_price
      t.string :final_currency
      t.boolean :ignore_from_calculations
      t.references :category
      t.references :user
      t.timestamps
    end
  end
end
