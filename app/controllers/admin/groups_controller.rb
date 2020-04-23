class Admin::GroupsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :find_event

  def index
  end

  def generate
    # 50 Teilnehmer insgesamt
    # mach 10 Gruppen á 5 Teilnehmer
    # mach für jede Gruppe einen DB Eintrag mit name = "Group " + index Zahl 

    # (Anzahl der Gruppen = Anzahl der Attendees, die attended haben / 6 )
    #p application.attended
    #
    # if @event.applications.attended && @event.applications.language_de 
    # attendants = @event.applications.attendants

    @attendants = @event.applications.application_selected.confirmed
    puts ('huhuu')
    puts @attendants
    
    # attendants.each do |attendant|
    #   puts ('huhuuu')
    #   puts @attendant
    # end
    puts @event.applications #.attendants 
      #attended = 'true')
    # end
    # Gruppennummer zuordnen put application_id in event_group_attendees
    # 

    redirect_to admin_event_groups_path(@event), notice: "Groups successfully generated"
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
