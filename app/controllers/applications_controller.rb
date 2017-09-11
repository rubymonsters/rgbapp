class ApplicationsController < ApplicationController

  before_action :require_admin, only: [:index, :select]
  before_action :find_event

  def new
    @application = Application.new
  end

  def create
    @application = @event.applications.build(params.require(:application).permit(:name,
      :email, :language_de, :language_en, :attended_before, :rejected_before, :level,
      :comments, :os, :needs_computer, :read_coc, :female))

    unless @application.save
      render :new
    end
  end

  def index
    @applications = @event.applications.order(params[:order] || "created_at desc")
    respond_to do |format|
      format.html
      format.csv { send_data @applications.to_csv }
    end
  end

  def select
    @event.applications.update_all(["selected = (id IN (?))", params[:selected_ids]])
    redirect_to event_applications_path(@event), notice: "Cool! Changes saved."
  end

  def require_admin
    require_login
    if current_user && !current_user.admin
      redirect_to new_event_application_path(params[:event_id])
    end
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

end
