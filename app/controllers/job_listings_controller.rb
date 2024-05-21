class JobListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_listing, only: [:show, :edit, :update, :destroy]

  def index
    @job_listings = current_user.job_listings
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

  private

  def set_job_listing
    @job_listing = current_user.job_listings.find(params[:id])
  end

  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :requirements, :salary)
  end
end
