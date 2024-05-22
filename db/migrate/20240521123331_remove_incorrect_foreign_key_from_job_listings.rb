class RemoveIncorrectForeignKeyFromJobListings < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :job_listings, column: :owner_id
    add_foreign_key :job_listings, :users, column: :owner_id
  end
end
