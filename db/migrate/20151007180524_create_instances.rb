class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.text :yaml_data
      t.references :task, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
