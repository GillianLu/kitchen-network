class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.references :job_listing, foreign_key: true
      t.bigint :reviewer_id
      t.bigint :reviewee_id

      t.timestamps
    end
    
    add_foreign_key :reviews, :users, column: :reviewer_id
    add_foreign_key :reviews, :users, column: :reviewee_id
  end
end
