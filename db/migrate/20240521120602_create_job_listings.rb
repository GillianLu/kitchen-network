class CreateJobListings < ActiveRecord::Migration[7.1]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.decimal :salary
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
