class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, presence: true # Name of transaction
  validates :date, presence: true # Date of transaction
  validates :original_price, presence: true # Original Price
  validates :original_currency, presence: true # Original Currency
  validates :final_price, presence: true # Final Price
  validates :final_currency, presence: true # Final Currency
  validates :category_id, presence: true # user_id (A transaction is specific for to a category)
  validates :user_id, presence: true # user_id (A transaction is specific for to a user)

  before_save :set_hash

  def set_hash
    self.hex_hash = Digest::SHA1.hexdigest("#{self.name}-#{self.original_price}-#{self.original_currency}")
  end
end
