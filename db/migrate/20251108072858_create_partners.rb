class CreatePartners < ActiveRecord::Migration[7.2]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :code, null: false

      t.timestamps
    end
  end
end
