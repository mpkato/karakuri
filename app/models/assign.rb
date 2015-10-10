class Assign < ActiveRecord::Base
  belongs_to :user
  belongs_to :task_set

  attr_accessor :name
end
