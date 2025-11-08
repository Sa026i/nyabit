class CreateBoardAchievements < ActiveRecord::Migration[7.2]
  def change
    create_table :board_achievements do |t|
      t.references :board, null: false, foreign_key: true
      t.references :habit_log, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
