class HabitsController < ApplicationController
    before_action :authenticate_user! #ログイン済みユーザーでなければログイン画面にはじく
    before_action :set_partners, only: %i[new create index] #パートナーの全id取得。習慣登録画面用

    def index
        @habit = Habit.new
        @habits = current_user.habits.includes(:partner)
    end

    def new
        @habit = Habit.new #これいるんかわからん...🥺
    end

    def create
        @habit = current_user.habits.build(habit_params)
        if @habit.save
            respond_to do |format|
                format.turbo_stream do
                    flash.now[:notice] = "習慣を登録しました！" # ブラウザから送られてきたリクエストのヘッダーにTurbo関係のリクエストが含まれている場合に呼ばれる。これがあるとcreate.turbo_stream.erbを探しにいく
                end
                format.html do
                    redirect_to habits_path, notice: "習慣を登録しました" #ブラウザから送られてきたリクエストが通常のhtmlレスポンスだった場合の救済処置　普通にリダイレクトする
                end
            end
        else
            respond_to do |format|
                format.turbo_stream do
                    flash.now[:alert] = "登録に失敗しました"
                    render :error, status: :unprocessable_entity
                end # error.turbo_stream.erb を用意！
                format.html do
                    render :index, status: :unprocessable_entity
                end
            end
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def set_partners
        @partners = Partner.all
    end

    def habit_params
        params.require(:habit).permit(:title, :partner_id )
    end
end
