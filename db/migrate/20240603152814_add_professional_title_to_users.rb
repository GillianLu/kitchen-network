class AddProfessionalTitleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :professional_title, :string
  end
end
