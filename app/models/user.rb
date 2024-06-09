# app/models/user.rb

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :role
  has_one_attached :photo

  has_many :job_listings, foreign_key: 'owner_id'
  has_many :applied_jobs, foreign_key: 'talent_id'
  has_many :applied_job_listings, through: :applied_jobs, source: :job_listing

  has_many :client_transactions, class_name: 'Transaction', foreign_key: 'client_id'
  has_many :talent_transactions, class_name: 'Transaction', foreign_key: 'talent_id'

  has_many :reviews_received, class_name: 'Review', foreign_key: 'reviewee_id', dependent: :destroy
  has_many :reviews_given, class_name: 'Review', foreign_key: 'reviewer_id', dependent: :destroy

  validates :first_name, :last_name, :email, :role_id, presence: true

  #To upload the resume
  mount_uploader :resume, ResumeUploader


  has_many :sent_messages, class_name: 'Message', foreign_key: 'message_sender_id', dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'message_receiver_id', dependent: :destroy


  def admin?
    role.role_name == 'admin'
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
