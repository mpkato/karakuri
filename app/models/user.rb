class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :task_templates, dependent: :destroy
  has_many :assigns, dependent: :destroy
  has_many :assigned_task_sets, through: :assigns, source: :task_set
  has_many :task_results

  def assigned_tasks
    Task.joins(task_set: :assigns)
      .where("assigns.user_id = ?", self.id).order(:task_set_id, :id).all
  end

  def assigned_task_results
    TaskResult.joins(task: {task_set: :assigns})
      .where("assigns.user_id = ?", self.id).all
  end

  def next_task(task_id)
    task = Task.find(task_id)
    Task.joins(task_set: :assigns)
      .where("assigns.user_id = ? and tasks.id > ? and tasks.task_set_id = ?",
      self.id, task_id, task.task_set_id)
      .order(:task_set_id, :id).first
  end

  def finished_task_results(task_set)
    task_results.joins(:task).where("tasks.task_set_id = ?", task_set.id).all
  end
end
