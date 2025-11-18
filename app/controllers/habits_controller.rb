class HabitsController < ApplicationController
    before_action :authenticate_user! #ログイン済みユーザーでなければログイン画面にはじく
    before_action :set_partners  #パートナーの全id取得。習慣登録画面用
    before_action :set_habit, only: %i[edit update destroy] #パラメーターから選択された習慣を取得

    def index
        @habit = Habit.new
        @habits = current_user.habits.where(is_active: true).includes(:partner)
    end

    def new
        @habit = Habit.new #これいるんかわからん...🥺
    end

    def create
        existing = current_user.habits.find_by(title: habit_params[:title]) # ユーザーの中で同じタイトルのhabitがあるか探す
        if existing #同じタイトルすでにあるパターン...indexに復活させる！
            if existing.update(is_active: true, partner_id: habit_params[:partner_id])
                @habit = existing
                respond_create_success
            else
                @habit = existing
                respond_create_failure
            end
        else
        @habit = current_user.habits.new(habit_params) #同じタイトルないパターン...ターボ動かして作る
            if @habit.save
                respond_create_success
            else
                respond_create_failure
            end
        end
    end


    def edit

    end



    def update
        if @habit.update(habit_params)
            respond_to do |format|
                format.turbo_stream do
                    flash.now[:notice] = "習慣を編集しました" # ブラウザから送られてきたリクエストのヘッダーにTurbo関係のリクエストが含まれている場合に呼ばれる。これがあるとcreate.turbo_stream.erbを探しにいく
                end
                format.html do
                    redirect_to habits_path, notice: "習慣を編集しました" #ブラウザから送られてきたリクエストが通常のhtmlレスポンスだった場合の救済処置　普通にリダイレクトする
                end
            end
        else
            respond_to do |format|
                format.turbo_stream do
                    flash.now[:alert] = "習慣の編集に失敗しました"
                    render :error, status: :unprocessable_entity
                end # error.turbo_stream.erb を用意！
                format.html do
                    render :index, status: :unprocessable_entity
                end
            end
        end
    end

    def destroy
        @habit.is_active = false
        @habit.save
        redirect_to habits_path, notice: "習慣を削除しました"
    end

    private

    def set_partners
        @partners = Partner.all
    end

    def habit_params
        params.require(:habit).permit(:title, :partner_id )
    end

    def set_habit
        @habit = current_user.habits.find(params[:id])
    end

    def respond_create_success
        respond_to do |format|
            format.turbo_stream do
                flash.now[:notice] = "習慣を登録しました！"
            end
            format.html do
                redirect_to habits_path, notice: "習慣を登録しました"
            end
        end
    end

    def respond_create_failure
        respond_to do |format|
            format.turbo_stream do
                flash.now[:alert] = "登録に失敗しました"
                render :error, status: :unprocessable_entity
            end
            format.html do
                render :index, status: :unprocessable_entity
            end
        end
    end

end
