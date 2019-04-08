class CoachesController < ApplicationController
  layout "coach", except: :new
  before_action :require_coach, except: [:new, :create]
  
  def new
    @coach = Coach.new
    @coach.build_user
  end

  def create
    coach_params = params.require(:coach).permit(:name, :female, :language_en, :language_de, :notifications)
    users_params = params.require(:coach).require(:user_attributes).permit(:email, :password)
#     all_params = params.require(:coach).permit(user_attributes => [[:email, :password]], :name, :female, :language_en, :language_de, :notifications)
    @coach = Coach.new(coach_params)
    @coach.build_user(users_params)
    if @coach.save
      redirect_to coach_url(@coach)
    else
      render :new
    end
  end

  def show
    @user = current_user
    @coach = @user.coach
  end
  
end