class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.bigint :client_id, null: false
      t.bigint :talent_id, null: false
      t.bigint :job_listing_id, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_foreign_key :transactions, :users, column: :client_id
    add_foreign_key :transactions, :users, column: :talent_id
    add_foreign_key :transactions, :job_listings, column: :job_listing_id

    add_index :transactions, :client_id
    add_index :transactions, :talent_id
    add_index :transactions, :job_listing_id
  end
end
