class ChangeTaskTemplateTaskRelationship < ActiveRecord::Migration
  def change
    remove_column :tasks, :task_template_id
    add_column :tasks, :task_set_id, :integer, index: true
  end
end
