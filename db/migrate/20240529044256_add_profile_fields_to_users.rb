class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :resume, :string
    add_column :users, :skills, :text
    add_column :users, :experience, :text
    add_column :users, :education, :text
  end
end
