class Assign < ActiveRecord::Base
  belongs_to :user
  belongs_to :task_set
  before_save :set_user

  attr_accessor :name

  def set_user
    user = User.find_by(username: name)
    if user.nil?
      errors.add(:name, "User #{name} was been found")
      return false
    else
      if Assign.find_by(user_id: user.id, task_set_id: self.task_set_id)
        errors.add(:name, "User #{name} has already been assigned")
        return false
      else
        self.user_id = user.id
        return true
      end
    end
  end
end
