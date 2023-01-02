class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.enum :income, enum_type: :income_category
      t.references :user
      t.timestamps
    end
  end
end
