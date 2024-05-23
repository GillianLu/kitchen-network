class HomeController < ApplicationController
  skip_before_action :authenticate_user!, except: [:dashboard]
  before_action :check_if_logged_in, except: [:dashboard]

  def index
  end

  def confirmed
    @resource = User.find(params[:resource_id])
  end

  def registered
    @resource = User.find(params[:resource_id])
  end

  def dashboard
    @jobs = JobListing.includes(:owner).order(created_at: :desc).limit(5)
  end

  private

  def check_if_logged_in
    redirect_to dashboard_path if current_user
  end
end
