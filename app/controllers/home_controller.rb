class HomeController < ApplicationController
  skip_before_action :authenticate_user!, except: [:dashboard]
  before_action :check_if_logged_in, except: [:dashboard, :reviews]

  def index
  end

  def confirmed
    @resource = User.find(params[:resource_id])
  end

  def registered
    @resource = User.find(params[:resource_id])
  end

  def reviews
    @reviews_received = Review.where(reviewee_id: current_user.id)
    @reviews_sent = Review.where(reviewer_id: current_user.id)
  end

  def dashboard
    @jobs = JobListing.includes(:owner).order(created_at: :desc).limit(5)
  end

  private

  def check_if_logged_in
    redirect_to dashboard_path if current_user
  end
end
