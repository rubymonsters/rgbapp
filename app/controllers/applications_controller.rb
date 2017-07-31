class ApplicationsController < ApplicationController

  before_action :require_admin, only: [:index]

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(params.require(:application).permit(:name,
      :email, :language_de, :language_en, :attended_before, :rejected_before, :level,
      :comments, :os, :needs_computer, :read_coc, :female))

    unless @application.save
      render :new
    end
  end

  def index
    @applications = Application.order(params[:order] || "created_at desc")
  end

  def require_admin
    require_login
    if current_user && !current_user.admin
      redirect_to root_path
    end
  end
end
