class CreateAppliedJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :applied_jobs do |t|
      t.references :job_listing, null: false, foreign_key: true
      t.references :talent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
