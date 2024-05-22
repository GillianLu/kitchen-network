class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!
    before_action :set_user, only: [:edit, :update]

    
    def index
        @users = User.where.not(confirmed_at: nil)
                    .includes(:role)
                    .where(roles: { role_name: 'user' })
        render :index
    end
    
    def moderators
        @moderators = User.where.not(confirmed_at: nil)
                        .includes(:role)
                        .where(roles: { role_name: 'moderator' })
        render :moderators
    end
    
    def pending_users
        @users = User.where(confirmed_at: nil)
                    .includes(:role)
                    .where(roles: { role_name: ['user', 'moderator'] })
        render :pending_users
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            redirect_to admin_user_path(@user), notice: 'The user has been updated successfully!'
        else
            render :edit, alert: 'Something went wrong with the user update.'
        end
    end
    
    private

    def set_user
        @user = User.find_by(id: params[:id])
        redirect_to admin_users_path, alert: 'The user could not be found.' unless @user
    end
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :role_id)
    end
    
    def ensure_admin!
        redirect_to root_path, alert: "You don't have permission to access this page." unless current_user.admin?
    end      
end
