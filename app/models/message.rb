class Message < ApplicationRecord
    belongs_to :message_sender, class_name: 'User'
    belongs_to :message_receiver, class_name: 'User'
end
  