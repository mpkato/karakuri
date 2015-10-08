class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :yaml_data
      t.references :task_template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
