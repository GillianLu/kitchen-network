class HomeController < ApplicationController
  skip_before_action :authenticate_user!, except: [:dashboard]
  before_action :check_if_logged_in, except: [:dashboard, :reviews, :transactions, :search_job]

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

  def transactions
    if current_user.role_id == 3
      @transactions = current_user.client_transactions
      @total_spent = current_user.client_transactions.sum(:amount)
      @talents_hired = current_user.client_transactions.distinct.count(:talent_id)
      @transactions_count = current_user.client_transactions.count
    else
      @transactions = current_user.talent_transactions
    end
  end

  def search_job
    @job_listings = JobListing.all
    if params[:query].present?
      search_query = "%#{params[:query]}%"
      @job_listings = @job_listings.where("title ILIKE :query OR description ILIKE :query OR requirements ILIKE :query", query: search_query)
    end
    render 'job_listings/browse'
  end

  
  private

  def check_if_logged_in
    redirect_to dashboard_path if current_user
  end
end
