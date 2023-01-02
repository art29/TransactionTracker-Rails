class AddIncomeCategoryEnum < ActiveRecord::Migration[7.0]
  def up
    create_enum :income_category, %w[income expense neutral]
  end

  def down
    # While there is a `create_enum` method, there is no way to drop it. You can
    # how ever, use raw SQL to drop the enum type.
    execute <<-SQL
      DROP TYPE income_category;
    SQL
  end
end
