class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :username
  validates_presence_of :username

  has_one :role, dependent: :destroy
  has_many :task_templates, dependent: :destroy

  after_create :create_role

  def create_role
    self.role = Role.create(role_type: Role.role_types['worker'])
  end
end
