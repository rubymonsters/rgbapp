class ApplicationsController < ApplicationController
  def new
    @application = Application.new
  end

  def create
    @application = Application.new(params.require(:application).permit(:name,
      :email, :language_de, :language_en, :attended_before, :rejected_before, :level,
      :comments, :os, :needs_computer))

    if @application.save
      redirect_to application_path
    else
      render :new
    end
  end


end
