class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  layout :choose_layout

private

  def require_admin
    require_login
    if current_user && !current_user.admin
      redirect_to root_path
    end
  end
  
  def logged_in_coach?
    @coach = current_user.coach if current_user      
  end

  def choose_layout
    logged_in_coach? ? "coach":nil
  end
  
  def require_coach
    unless logged_in_coach?
      store_location
      flash[:notice] = "You need to be signed in as coach"
      redirect_to coaches_sign_in_path
    end
  end

  def require_signed_out
    redirect_to logged_in_path if current_user
  end
end
