class AppliedJob < ApplicationRecord
  belongs_to :job_listing
  belongs_to :talent, class_name: 'User'

  validates :job_listing_id, :talent_id, presence: true

  def self.confirm_application(current_user, job_listing_id, applicant_id)
    job_listing = current_user.job_listings.find_by(id: job_listing_id)
    applied_job = job_listing.applied_jobs.find_by(id: applicant_id)

    return { success: false, message: 'Job not found.' } if job_listing.nil?
    return { success: false, message: 'Applicant not found.' } if applied_job.nil?
    return { success: false, message: 'Unauthorized' } unless current_user.role.role_name == 'owner' && job_listing.owner == current_user

    ActiveRecord::Base.transaction do

      # pwede pa i-update yung ibang existing na application na pending -> rejected na.
      
      if job_listing.update(status: 'assigned') && applied_job.update(status: 'confirmed', balance: job_listing.salary)
        { success: true, message: 'Application confirmed. Please proceed to payment.'}
      else
        { success: false, message: 'Failed to confirm application.' }
      end
    end
  end
  
end
