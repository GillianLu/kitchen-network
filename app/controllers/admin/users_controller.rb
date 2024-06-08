class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!
    before_action :set_user, only: [:edit, :update]

    
    def index
        @users = User.where.not(confirmed_at: nil)
                    .includes(:role)
                    .where(roles: { role_name: 'owner' })
        render :index
    end
    
    def talents
        @users = User.where.not(confirmed_at: nil)
                       .includes(:role)
                       .where(roles: { role_name: 'talent' })
        render :talents
    end
    
    def pending_users
        @users = User.where(confirmed_at: nil)
                    .includes(:role)
                    .where(roles: { role_name: ['owner', 'talent'] })
        render :pending_users
    end
    
    def edit
        if @user.confirmed_at.nil?
            redirect_to admin_users_pending_path, alert: 'Pending users cannot be edited.'
        end
    end
    
    def update
        if @user.update(user_params)
            if @user.role.role_name == 'talent'
                redirect_to admin_talents_path, notice: 'The user has been updated successfully!'
            else
                redirect_to admin_users_path, notice: 'The user has been updated successfully!'
            end
        else
            render :edit, alert: 'Something went wrong with the user update.'
        end
    end

    def transactions 
        @transactions = Transaction.includes(:client, :talent, :job_listing).all
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
