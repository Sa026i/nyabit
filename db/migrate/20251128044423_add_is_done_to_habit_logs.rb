class AddIsDoneToHabitLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :habit_logs, :is_done, :boolean, default: false
  end
end
