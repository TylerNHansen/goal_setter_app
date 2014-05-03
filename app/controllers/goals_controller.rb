class GoalsController < ApplicationController

  before_action :set_user # except for the current user's goal index
  before_action :set_goal, only: [:edit, :update, :show, :destroy]

  def new
    @goal = Goal.new
  end

  def index
    @goals = @user.goals
    @uncompleted = @goals.reject(&:completed?)
    @completed = @goals.select(&:completed?)
  end

  def show

  end

  def create
    @goal = @user.goals.new(goal_params)

    if @goal.save
      redirect_to user_goal_url(@user, @goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    if @goal.update(goal_params)
      redirect_to user_goal_url(@user, @goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def edit

  end

  def destroy
    @goal.delete
    redirect_to user_goals_url(@user)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_goal
    @goal = Goal.find(params[:id])
    redirect_to user_goals_url(@user) unless @goal
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :completed)
  end


end
