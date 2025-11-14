class Habit < ApplicationRecord
    belongs_to :user
    belongs_to :partner
    has_many :habit_logs

    validates :title,length: { minimum: 1, maximum: 15 },presence: true
    validates :partner,presence: { message: "パートナーが未選択だよ"}
end
