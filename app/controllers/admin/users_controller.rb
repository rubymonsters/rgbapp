class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :require_admin
  before_action :find_user, except: [:index]

  def index
    @users = User.all
  end

  def update
    if @user == current_user
      flash[:error] = "You cannot change the logged in user."
    else
      @user.admin = !@user.admin
      @user.save
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user == current_user
      flash[:error] = "You cannot delete the logged in user."
    else
      @user.destroy
    end
    redirect_to admin_users_path
  end

  def block
    @user.update_attributes(is_blocked: true)
    @coach = Coach.where(user_id: @user.id).first
    @coach_applications = CoachApplication.where(coach_id: @coach.id)
    @coach_applications.each do |coach_application|
      coach_application.update(state: 'rejected')
    end
    flash[:notice] = "User is blocked"
    redirect_to admin_users_path
  end

  def unblock
    @user.update_attributes(is_blocked: false)
    flash[:notice] = "User is unblocked"
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
