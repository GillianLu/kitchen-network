class ReviewsController < ApplicationController
  before_action :set_job_listing, only: [:new, :create]
  before_action :set_review, only: [:edit, :update, :destroy]

  def user_reviews
    @user = User.find(params[:id])
    @reviews = Review.where(reviewee_id: @user.id)
  end

  def new
    if @job_listing.status != 'completed'
      redirect_to job_listings_path, alert: "Please mark the job as completed to proceed with the review."
    elsif @job_listing.review != nil
      redirect_to job_listings_path, alert: "You have already reviewed this job listing."
    else
      @review = Review.new
      @applied_job = @job_listing.applied_jobs.find_by(status: 'confirmed')
      @client = @job_listing.owner
      @reviewee = User.find(@applied_job.talent_id)
    end
  end

  def create
    @job_listing = JobListing.find(params[:job_listing_id])

    if @job_listing.status == 'completed'
      @reviewee = @job_listing.applied_jobs.find_by(status: 'confirmed')

      @review = @job_listing.build_review(review_params)

      if current_user.role_id == 3
        @review.reviewer_id = current_user.id
        @review.reviewee_id = @reviewee.talent_id
      elsif current_user.role_id == 2
        @review.reviewer_id = current_user.id
        @review.reviewee_id = @job_listing.owner.id
      end

      if @review.save
        redirect_to reviews_path, notice: "Review submitted successfully."
      else
        flash[:alert] = "Review submission failed: #{@review.errors.full_messages.join(', ')}"
        redirect_to job_listings_path
      end
    else
      redirect_to job_listings_path, alert: "Please mark the job as completed to proceed with the review."
    end
  end

  def edit
    if @review.reviewer_id != current_user.id || @review.job_listing.owner != current_user
      redirect_to reviews_path, alert: "You are not authorized to edit this review."
    end
  end


  def update
    # Ensure the user is authorized to update this review
    if @review.reviewer_id != current_user.id || @review.job_listing.owner != current_user
      redirect_to reviews_path, alert: "You are not authorized to update this review."
    end

    # Attempt to update the review with the provided parameters
    if @review.update(review_params)
      redirect_to reviews_path, notice: "Review updated successfully."
    else
      render :edit
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
