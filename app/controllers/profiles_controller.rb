class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = Review.where(reviewee_id: @user.id)
  end

  def talents
    @talents = User.joins(:role).where(roles: { role_name: 'talent' })
  end

end
