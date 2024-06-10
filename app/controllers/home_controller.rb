class HomeController < ApplicationController
  skip_before_action :authenticate_user!, except: [:dashboard]
  before_action :check_if_logged_in, except: [:dashboard, :reviews, :transactions, :search_job, :user_reviews]

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

  def user_reviews
    @reviews_received = Review.where(reviewee_id: params[:user_id])
    render :reviews
  end

  def dashboard
    @jobs = JobListing.includes(:owner).order(created_at: :desc).limit(5)
    if current_user.role.role_name == 'talent'
      @job_listings = JobListing.where.not(status: 'completed')
      @owners = User.where(role_id: Role.find_by(role_name: 'owner').id) || []
      @applications = current_user.applied_jobs
      @jobs_done = JobListing.where(status: 'completed')
      @total_earned = current_user.talent_transactions.sum(:amount)
      @clients_count = current_user.talent_transactions.distinct.count(:client_id)
      @transactions_count = current_user.talent_transactions.count
    elsif current_user.role.role_name == 'owner'
      @job_listings = current_user.job_listings.where.not(status: 'completed')
      @applications = current_user.job_listings.map(&:applied_jobs).flatten
      @job_lisitng = current_user.job_listings.order(created_at: :desc).limit(5)
      @jobs_done = current_user.job_listings.where(status: 'completed')
      @total_spent = current_user.client_transactions.sum(:amount)
      @talents_hired = current_user.client_transactions.distinct.count(:talent_id)
      @transactions_count = current_user.client_transactions.count
    end
  end

  def transactions
    if current_user.role.role_name == 'owner'
      @transactions = current_user.client_transactions
      @total_spent = current_user.client_transactions.sum(:amount)
      @talents_hired = current_user.client_transactions.distinct.count(:talent_id)
      @transactions_count = current_user.client_transactions.count
    else
      @transactions = current_user.talent_transactions
      @total_earned = current_user.talent_transactions.sum(:amount)
      @clients_count = current_user.talent_transactions.distinct.count(:client_id)
      @transactions_count = current_user.talent_transactions.count
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
