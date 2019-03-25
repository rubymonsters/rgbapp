class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

private

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def require_admin
    require_login
    if current_user && !current_user.admin
      redirect_to root_path
    end
  end
end
