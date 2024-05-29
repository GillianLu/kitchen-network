class Transaction < ApplicationRecord
    belongs_to :client, class_name: 'User'
    belongs_to :talent, class_name: 'User'
    belongs_to :job_listing
  
    validates :amount, presence: true
    validate :client_role_must_be_correct
    validate :talent_role_must_be_correct
    validate :client_and_talent_must_be_different
  
    private
  
    def client_role_must_be_correct
        errors.add(:client, 'must have a role of client.') unless client&.role_id == 3
    end

    def talent_role_must_be_correct
        errors.add(:talent, 'must have a role of talent.') unless talent&.role_id == 2
    end

    def client_and_talent_must_be_different
        errors.add(:base, 'Client and talent must not be the same user.') if client_id == talent_id
    end

    def self.send_payment(current_user, job_listing_id, applied_job_id)
        job_listing = current_user.job_listings.find_by(id: job_listing_id)
        applied_job = job_listing.applied_jobs.find(applied_job_id)
        amount = job_listing.salary.to_i / 2

        return { success: false, message: 'Job not found.' } if job_listing.nil?
        return { success: false, message: 'Applicant not found.' } if applied_job.nil?
        return { success: false, message: 'Unauthorized' } unless current_user.role.role_name == 'owner' && job_listing.owner == current_user
    
        ActiveRecord::Base.transaction do
            transaction = Transaction.new(
                client_id: current_user.id,
                talent_id: applied_job.talent_id,
                job_listing_id: job_listing.id,
                amount: amount
            )

            if transaction.save
                { success: true, message: 'Payment Succesful.'}
            else
                { success: false, message: 'Failed to confirm application.' }
            end
        end
    end

end
  