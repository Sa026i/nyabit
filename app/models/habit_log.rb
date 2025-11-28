class HabitLog < ApplicationRecord
    belongs_to :user
    belongs_to :habit
end

# カリキュラムより
# xxxx 関連付けられた親オブジェクトを返す。例えば、Postモデルに belongs_to :user と定義されている場合、post.user メソッドはその投稿の所有者であるユーザーを取得する。
# build_xxxx 例えば、user.build_postとすることで、関連付けられた新しい投稿オブジェクトを生成しますが、この段階ではデータベースに保存され
# create_xxxx
# etc