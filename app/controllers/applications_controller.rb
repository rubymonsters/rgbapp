class ApplicationsController < ApplicationController

  before_action :require_admin, only: [:index, :select]
  before_action :find_event

  def new
    if Time.now < @event.application_start
      render :too_early
    elsif Time.now > @event.application_end
      render :too_late
    else
      @application = Application.new
    end
  end

  def create
    @application = @event.applications.build(params.require(:application).permit(:name,
      :email, :language_de, :language_en, :attended_before, :rejected_before, :level,
      :comments, :os, :needs_computer, :read_coc, :female))

    if @application.save
      UserMailer.application_mail(@application).deliver_later
    else
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
    if params[:selected_ids]
      @event.applications.update_all(["selected = (id IN (?))", params[:selected_ids]])
    else
      @event.applications.update_all(selected: false)
    end
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
