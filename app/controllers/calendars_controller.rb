class CalendarsController < ApplicationController
    before_action :authenticate_user!

    def index
        @habit_logs = current_user.habit_logs
    end
end
