class Task < ActiveRecord::Base
  belongs_to :task_template
  serialize :yaml_data
end
