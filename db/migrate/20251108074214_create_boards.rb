class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.date :posted_on, null: false
      t.string :title
      t.text :body
      t.boolean :is_visibility, default: true
      t.integer :likes_count, default: 0
      t.integer :achieved_count

      t.timestamps
    end
  end
end
