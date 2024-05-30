class AppliedJobsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def index
    @applied_jobs = current_user.applied_jobs.includes(job_listing: :owner)
  end

  def apply
    @job_listing = JobListing.find(params[:job_listing_id])
    if current_user.role.role_name == 'talent' && @job_listing
      @applied_job = current_user.applied_jobs.new(job_listing_id: @job_listing.id)
      if @applied_job.save
        redirect_to applied_jobs_path, notice: 'You have successfully applied to the job listing.'
      else
        redirect_to job_listings_path, alert: 'Failed to apply to the job listing.'
      end
    else
      redirect_to root_path, alert: 'Unauthorized'
    end
  end

  def destroy
    @applied_job = current_user.applied_jobs.find(params[:id])
    @applied_job.destroy
    redirect_to applied_jobs_path, notice: 'Application successfully rescinded.'
  end

  private

  def authorize_user!
    if current_user.role.role_name == 'talent'
      allow_talent_access
    elsif current_user.role.role_name == 'owner'
      allow_owner_access
    else
      redirect_to root_path, alert: 'Unauthorized'
    end
  end

  def allow_talent_access
    unless %w[index apply destroy].include?(params[:action])
      redirect_to root_path, alert: 'Unauthorized'
    end
  end

  def allow_owner_access
    unless params[:controller] == 'job_listings' || (params[:controller] == 'applied_jobs' && params[:action] == 'index')
      redirect_to root_path, alert: 'Unauthorized'
    end
  end
end
