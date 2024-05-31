class AppliedJob < ApplicationRecord
  belongs_to :job_listing
  belongs_to :talent, class_name: 'User'

  validates :job_listing_id, :talent_id, presence: true
end
