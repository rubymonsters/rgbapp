class CoachesController < ApplicationController
  before_action :require_coach, except: [:new, :create]
  before_action :require_signed_out, only: :new

  def new
    @coach = Coach.new
    @coach.build_user
  end

  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      redirect_to edit_coach_path(@coach)
    else
      render :new
    end
  end

  def edit
    @coach = find_coach
  end

  def update
    @coach = Coach.find(params[:id])
    if !@coach.update(coach_params)
      render :edit
    end
  end

  def show
    @coach = Coach.find(params[:id])
  end

  private
  def coach_params
    params.require(:coach).permit(:name,
                                  :female,
                                  :language_en,
                                  :language_de,
                                  :notifications,
                                  user_attributes: [:email,:password])
  end

  def find_coach
    Coach.find(params[:id])
  end

end