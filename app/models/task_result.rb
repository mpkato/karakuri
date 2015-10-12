class TaskResult < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  serialize :submitted_data
  validate :require_all_parameters
  validates_presence_of :task_id, :user_id

  def require_all_parameters
    return if task.nil?
    unless Hash === submitted_data
      errors.add(:submitted_data, "Submitted data must be Hash")
      return 
    end
    task.variables.each do |v|
      unless submitted_data.include?(v) and not submitted_data[v].empty?
        errors.add(v, "is empty")
      end
    end
  end
end
