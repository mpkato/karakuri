class TaskResult < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  serialize :submitted_data
  validate :require_all_parameters

  def require_all_parameters
    task.variables.each do |v|
      unless submitted_data.include?(v) and not submitted_data[v].empty?
        errors.add(v, "is empty")
      end
    end
  end
end
