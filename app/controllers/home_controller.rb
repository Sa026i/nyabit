class HomeController < ApplicationController
  before_action :authenticate_user!
  def top
    @habits = current_user.habits.where(is_active: true).includes(:partner)

    today = Time.zone.today
    @completed_habit_ids = current_user.habit_logs.where(logged_on: today,is_done: true).pluck(:habit_id).to_set
  end
end
