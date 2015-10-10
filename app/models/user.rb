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
end
