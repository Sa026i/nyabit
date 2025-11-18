class Habit < ApplicationRecord
    belongs_to :user
    belongs_to :partner
    has_many :habit_logs

    validates :title,length: { minimum: 1, maximum: 15 },presence: true
    validates :partner,presence: { message: "パートナーが未選択だよ"}
    validate  :active_limit_per_user, if: :is_active?


    private

    def active_limit_per_user
        # Habitデータ3件以上有効にしないためのバリデーション
        return unless user

        active_count = user.habits.where(is_active: true).where.not(id: id).count
        # where.not(id: id)は、そのHabitのidがDBにあるなら主キーを、ないならnilが入る。登録しようとしているHabitの主キー以外のデータが3件以上かどうか調べるため！
        if active_count >= 3
            errors.add(:base, "一度に登録できる習慣は3つまで")
        end
    end
end
