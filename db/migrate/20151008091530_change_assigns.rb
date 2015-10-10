class ChangeAssigns < ActiveRecord::Migration
  def change
    remove_column :assigns, :task_template_id
    add_column :assigns, :task_set_id, :integer, index: true
  end
end
