class CreateTaskTemplates < ActiveRecord::Migration
  def change
    create_table :task_templates do |t|
      t.string :label
      t.string :title_template
      t.text :form_template
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
