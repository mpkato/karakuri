class CreateAssigns < ActiveRecord::Migration
  def change
    create_table :assigns do |t|
      t.references :user, index: true, foreign_key: true
      t.references :task_set, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
