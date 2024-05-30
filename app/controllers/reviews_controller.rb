class ReviewsController < ApplicationController
  before_action :set_job_listing, only: [:new, :create]
  before_action :set_review, only: [:destroy]

  def new
    if @job_listing.status != 'completed'
      redirect_to job_listings_path, alert: "Please mark the job as completed to proceed with the review."
    elsif @job_listing.review != nil
      redirect_to job_listings_path, alert: "You have already reviewed this job listing."
    else
      @review = Review.new
      @reviewee_id = @job_listing.applied_jobs.find_by(status: 'confirmed')
    end
  end

  def create
    if @job_listing.status = 'completed'
      @reviewee = @job_listing.applied_jobs.find_by(status: 'confirmed')
    
      if @reviewee.nil?
        redirect_to job_listings_path, alert: "No confirmed applicant found for review."
        return
      end
      
      @review = @job_listing.reviews.build(review_params)
      @review.reviewer_id = current_user.id 
      @review.reviewee_id = @reviewee.talent_id
      
      if @review.save
        redirect_to reviews_path, notice: "Review submitted successfully."
      else
        flash[:alert] = "Review submission failed: #{@review_errors}"
        redirect_to job_listings_path
      end
    else
      redirect_to job_listings_path, alert: "Please mark the job as completed to proceed with the review."
    end
  end

  def destroy
    if @review && @review.job_listing.owner == current_user
      @review.destroy
      redirect_to reviews_path, notice: "Review deleted successfully."
    else
      redirect_to reviews_path, alert: "You are not authorized to delete this review."
    end    
  end

  private

  def review_params
    params.require(:review).permit(:title, :content)
  end

  def set_job_listing
    @job_listing = JobListing.find(params[:job_listing_id])
  end

  def set_review
    @review = Review.find_by(id: params[:id], reviewer_id: current_user.id)
    unless @review
      redirect_to reviews_path, alert: "Review not found or you are not authorized to view it."
    end
  end
end