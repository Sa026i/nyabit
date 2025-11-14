class HabitsController < ApplicationController
    before_action :authenticate_user!

    def index
    end

    def new
        @habit = Habit.new
    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end
end
