class AddStatusToJobListings < ActiveRecord::Migration[7.1]
  def change
    add_column :job_listings, :status, :string, default: 'pending'
    add_column :applied_jobs, :balance, :decimal
  end
end