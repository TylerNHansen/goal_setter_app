class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.boolean :private, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.references :user, index: true
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
