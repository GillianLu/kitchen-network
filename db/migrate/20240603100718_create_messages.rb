class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.references :message_sender, null: false, foreign_key: { to_table: :users }
      t.references :message_receiver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    # Remove existing indexes if they exist
    if index_exists?(:messages, :message_sender_id)
      remove_index :messages, :message_sender_id
    end
    if index_exists?(:messages, :message_receiver_id)
      remove_index :messages, :message_receiver_id
    end

    # Add indexes conditionally
    add_index :messages, :message_sender_id unless index_exists?(:messages, :message_sender_id)
    add_index :messages, :message_receiver_id unless index_exists?(:messages, :message_receiver_id)
  end
end
