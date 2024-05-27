class AddDurationToJobListings < ActiveRecord::Migration[7.1]
  def change
    add_column :job_listings, :duration, :integer
  end
end
