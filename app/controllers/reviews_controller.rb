class ReviewsController < ApplicationController
  before_action :set_job_listing, only: [:new, :create, :destroy]

  def new
    if @job_listing.status != 'completed'
      redirect_to @job_listing, alert: "Please mark the job as completed to proceed with the review."
    else
      @review = Review.new
      @reviewee_id = @job_listing.applied_jobs.find_by(status: 'confirmed')
    end
  end

  def create
    if @job_listing.status = 'completed'
      @reviewee = @job_listing.applied_jobs.find_by(status: 'confirmed')
    
      if @reviewee.nil?
        redirect_to @job_listing, alert: "No confirmed applicant found for review."
        return
      end
      
      @review = @job_listing.reviews.build(review_params)
      @review.reviewer_id = current_user.id 
      @review.reviewee_id = @reviewee.talent_id
      
      if @review.save
        redirect_to @job_listing, notice: "Review submitted successfully."
      else
        flash[:alert] = "Review submission failed: #{@review_errors}"
        redirect_to @job_listing
      end
    else
      redirect_to @job_listing, alert: "Please mark the job as completed to proceed with the review."
    end
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:title, :content)
  end

  def set_job_listing
    @job_listing = JobListing.find(params[:job_listing_id])
  end
end
