class CoachesController < ApplicationController
  layout "coach", except: [:new, :create]
  before_action :require_coach, except: [:new, :create]
  before_action :find_coach, except: [:new, :create]
  before_action :require_signed_out, only: :new

  def new
    @coach = Coach.new
    @coach.build_user
  end

  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      sign_in(@coach.user)
      flash[:notice] = "Coach created successfully"
      redirect_to edit_coach_path(@coach)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @coach.update(coach_params)
      flash[:notice] = "Coach updated successfully"
      redirect_to edit_coach_path(@coach)
    else
      render :edit
    end
  end

  private

  def coach_params
    params.require(:coach).permit(:name,
                                  :female,
                                  :language_en,
                                  :language_de,
                                  :notifications,
                                  user_attributes: [:email, :password, :id])
  end

  def find_coach
    @coach = current_user.coach
  end
end
