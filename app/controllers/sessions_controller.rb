class SessionsController < Clearance::SessionsController
  def new_coach
    render template: "sessions/new_coach" 
  end
  def new_admin
    render template: "sessions/new_admin" 
  end
end