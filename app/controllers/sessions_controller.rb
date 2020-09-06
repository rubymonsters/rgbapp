class SessionsController < Clearance::SessionsController
  before_action :require_signed_out, only: [:new_coach,:new_admin]

  def new_coach
    render template: "sessions/new_coach"
  end

  def new_admin
    render template: "sessions/new_admin"
  end

  def create
    @user = authenticate(params)
    if @user.present? && @user.is_blocked
      flash[:error] = "You have been blocked! Contact an Admin for details."
      redirect_to coaches_sign_in_path
    else
      sign_in(@user) do |status|
        if status.success?
          redirect_back_or url_after_create
        else
          flash.now.alert = status.failure_message
          if params["user_type"] == "coach"
            render template: "sessions/new_coach", status: :unauthorized
          elsif params["user_type"] == "admin"
            render template: "sessions/new_admin", status: :unauthorized
          else
            render template: "clearance/sessions/new", status: :unauthorized
          end
        end
      end
    end
  end

  def url_after_create
    if params["user_type"] == "coach"
      flash[:notice] = "Welcome back! Do you want to coach an event?"
      events_coaches_path
    elsif params["user_type"] == "admin"
      admin_root_path
    else
      Clearance.configuration.redirect_url
    end
  end

  def logged_in
    render template: "sessions/logged_in"
  end

  def destroy_coach
    sign_out
    redirect_to coaches_sign_in_path
  end
end
