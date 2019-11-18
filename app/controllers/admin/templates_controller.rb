class Admin::TemplatesController < ApplicationController
  layout "admin"

  before_action :require_admin

  def edit
    @event = Event.find(params[:event_id])
  end

  def update
    @event = Event.find(params[:event_id])
    if @event.update_attributes(params.require(:event).permit(params[:id], params[:id] + "_subject"))
      flash[:notice] = "E-mail saved."
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end

  end
end
