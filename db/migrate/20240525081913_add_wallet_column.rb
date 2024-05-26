class AddWalletColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :wallet, :float
  end
end
