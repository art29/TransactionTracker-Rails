class Category < ApplicationRecord
  enum :income_category, { income: 'income', expense: 'expense', neutral: 'neutral' }
  belongs_to :user
  has_many :transactions

  before_create :set_order

  validates :name, presence: true # Name of category
  validates :income, inclusion: { in: %w[income expense neutral] } # Type of income (Income, Expense, Neutral)
  validates :user_id, presence: true # user_id (A category is specific for to a user)

  default_scope { order(:order) }

  def set_order
    self.order = Category.count
  end
end
