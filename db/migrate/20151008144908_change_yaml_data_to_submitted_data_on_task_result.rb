class ChangeYamlDataToSubmittedDataOnTaskResult < ActiveRecord::Migration
  def change
    rename_column :task_results, :yaml_data, :submitted_data
  end
end
