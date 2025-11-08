class CreateHabitLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :habit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :habit, null: false, foreign_key: true
      t.date :logged_on, null: false
      t.string :partner_code
      t.string :habit_title

      t.timestamps
    end
  end
end
