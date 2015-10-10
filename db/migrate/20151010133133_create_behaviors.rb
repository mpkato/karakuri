class CreateBehaviors < ActiveRecord::Migration
  def change
    create_table :behaviors do |t|
      t.integer :status
      t.references :task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
