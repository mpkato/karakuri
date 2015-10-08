class Assign < ActiveRecord::Base
  belongs_to :user
  belongs_to :task_template
end
