class AddStatusToAppliedJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :applied_jobs, :status, :string
  end
end
