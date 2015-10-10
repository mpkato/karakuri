class CreateTaskResults < ActiveRecord::Migration
  def change
    create_table :task_results do |t|
      t.references :task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :yaml_data

      t.timestamps null: false
    end
  end
end
