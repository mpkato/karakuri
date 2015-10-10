class AddCounterCachesToTaskSet < ActiveRecord::Migration
  def change
    add_column :task_sets, :tasks_count, :integer, default: 0
    add_column :task_sets, :assigns_count, :integer, default: 0
  end
end
