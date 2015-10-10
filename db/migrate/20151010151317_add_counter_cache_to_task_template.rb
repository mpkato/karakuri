class AddCounterCacheToTaskTemplate < ActiveRecord::Migration
  def change
    add_column :task_templates, :task_sets_count, :integer, default: 0
  end
end
