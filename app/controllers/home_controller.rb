class HomeController < ApplicationController
  def top
    @habits = current_user.habits.where(is_active: true).includes(:partner)

    today = Time.zone.today
    @completed_habit_ids = current_user.habit_logs.where(logged_on: today).pluck(:habit_id)
  end
end
