class AddSha1DigestToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :hex_hash, :text
  end
end
