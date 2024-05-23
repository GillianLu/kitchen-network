class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def confirmed
    @resource = User.find(params[:resource_id])
  end

  def registered
    @resource = User.find(params[:resource_id])
  end
end
