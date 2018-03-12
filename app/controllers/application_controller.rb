class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

private

  def require_admin
    require_login
    if current_user && !current_user.admin
      redirect_to root_path
    end
  end
end
