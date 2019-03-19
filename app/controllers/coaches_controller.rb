class CoachesController < ApplicationController
  
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
      render html: 'Success'
    else
      render :new
    end
  end
end