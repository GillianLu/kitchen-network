class JobListing < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :applied_jobs, dependent: :destroy
  has_many :talents, through: :applied_jobs

  has_many :transactions, dependent: :destroy
  has_one :review

  validates :title, :description, :requirements, :salary, :duration, presence: true
  validates :status, inclusion: { in: %w(pending assigned completed),
    message: "%{value} is not a valid status" }
end
