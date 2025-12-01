class HabitsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_partners
    before_action :set_habit, only: %i[edit update destroy]
    def index
        @habit = Habit.new
        @habits = current_user.habits.where(is_active: true).includes(:partner)
    end

    def new
        @habit = Habit.new #これいるんかわからん...🥺
    end

    def create
        title = habit_params[:title]

        # すでに有効な同名習慣がある場合は弾く
        active_existing = current_user.habits.find_by(title: title, is_active: true)
        if active_existing
            @habit = active_existing
            @habit.errors.add(:title, "同じ習慣を記録中だよ")
            return respond_create_failure
        end

        # 無効な同名習慣がある場合は復活させる
        existing = current_user.habits.find_by(title: title, is_active: false)
        if existing
            Habit.transaction do
                next_pos = current_user.habits.where(is_active: true).count + 1
                existing.update!(is_active: true, partner_id: habit_params[:partner_id], position: next_pos)
            end
            @habit = existing
            respond_create_success
        else
            @habit = current_user.habits.new(habit_params)
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
    Habit.transaction do
        removed_pos = @habit.position
        #後続を詰める
        current_user.habits.where("position > ?", removed_pos).update_all("position = position - 1")
        #無効化しつつpositionを外す
        @habit.update!(is_active: false, position: nil)
    end
    redirect_to habits_path, notice: "削除しました"
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
