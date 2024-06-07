class JobListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:index, :new, :create, :edit, :update, :destroy, :applicants]
  before_action :set_job_listing, only: [:show, :edit, :update, :destroy, :applicants, :confirm_applicant, :reject_applicant]

  def index
    if current_user.role.role_name == 'owner'
      @job_listings = current_user.job_listings
      # @assigned_applicant = @job_listing.applied_jobs.find_by(status: 'confirmed')
    else
      redirect_to applied_jobs_path
    end
  end

  def browse
    @job_listings = JobListing.all
  end

  def new
    @job_listing = current_user.job_listings.new
  end

  def create
    @job_listing = current_user.job_listings.new(job_listing_params)
    if @job_listing.save
      redirect_to @job_listing, notice: 'Job listing creation successful.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @job_listing.update(job_listing_params)
      redirect_to job_listings_path, notice: 'Job listing was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job_listing.destroy
    redirect_to job_listings_path, notice: 'Job listing was successfully deleted.'
  end

  def applicants
    @job_listing = current_user.job_listings.find(params[:id])
    @applicants = @job_listing.applied_jobs.includes(:talent)
  end

  def all_applicants
    if current_user.role.role_name == 'owner'
      @applicants = AppliedJob.joins(:job_listing).where(job_listings: { owner_id: current_user.id, status: 'pending' }).includes(:job_listing, :talent)
    else
      redirect_to root_path, alert: "You don't have access to this page."
    end
  end

  def confirm_applicant
    result = AppliedJob.confirm_application(current_user, params[:job_listing_id], params[:applicant_id])

    if result[:success]
      redirect_to applicants_job_listing_path(job_listing_id: params[:job_listing_id]), notice: result[:message]
    else
      redirect_to applicants_job_listing_path(@applied_job.job_listing), alert: result[:message]
    end
  end

  def reject_applicant
    @applied_job = AppliedJob.find(params[:applicant_id])
    if current_user.role.role_name == 'owner' && @applied_job.job_listing.owner == current_user
      @applied_job.update(status: 'rejected')
      redirect_to applicants_job_listing_path(@applied_job.job_listing), notice: 'Application rejected.'
    else
      redirect_to root_path, alert: 'Unauthorized'
    end
  end

  private

  def set_job_listing
    if current_user.role.role_name == 'owner'
      @job_listing = current_user.job_listings.find(params[:id])
    else
      @job_listing = JobListing.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Job listing not found or you are not authorized to view it.'
  end

  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :requirements, :duration, :salary)
  end

  def authorize_user!
    unless current_user.role.role_name == 'owner'
      redirect_to applied_jobs_path, alert: 'Unauthorized'
    end
  end
end
