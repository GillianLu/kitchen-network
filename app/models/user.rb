class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :role

  has_many :job_listings, foreign_key: 'owner_id'
  has_many :applied_jobs, foreign_key: 'talent_id'
  has_many :applied_job_listings, through: :applied_jobs, source: :job_listing

  validates :first_name, :last_name, :email, :role_id, presence: true

  def admin?
    role.role_name == 'admin'
  end
end
