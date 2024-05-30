class Review < ApplicationRecord
    belongs_to :job_listing
    belongs_to :reviewee, class_name: 'User', foreign_key: 'reviewee_id'
    belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'

    validates :job_listing_id, uniqueness: { scope: :reviewer_id, message: "You have already reviewed this job listing." }
end
