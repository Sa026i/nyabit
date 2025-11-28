class HabitLogsController < ApplicationController
    def create
        habit = current_user.habits.find(params[:habit_id]) # 自分の習慣のみ
        log = habit.habit_logs.find_or_initialize_by(logged_on: Date.current)

        # 1日1回: 未作成のときだけ作る
        if log.new_record?
            log.assign_attributes(
                user: current_user,
                habit_title: habit.title,
                partner_code: habit.partner.code,
                is_done: true
            )
            log.save!
        end

        @habit = habit
        @completed_today = true

        respond_to do |format|
            format.turbo_stream
            format.json { render json: { completed_today: true } }
        end
    end
end
