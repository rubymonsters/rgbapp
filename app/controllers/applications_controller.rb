class ApplicationsController < ApplicationController

  before_action :require_login, only: [:index]

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
    @applications = Application.all
  end

end
