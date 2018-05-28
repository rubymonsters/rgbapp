class Admin::UsersController < ApplicationController

  before_action :require_admin

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot change the logged in user."
    else
      @user.admin = !@user.admin
      @user.save
    end
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot delete the logged in user."
    else
      @user.destroy
    end
    redirect_to admin_users_path
  end
end
