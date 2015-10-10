class TaskSet < ActiveRecord::Base
  belongs_to :task_template, counter_cache: true
  has_many :tasks
  has_many :assigns, dependent: :destroy
  has_many :assigned_users, through: :assigns, source: :user

  attr_accessor :task_file
  validate :task_file_validation, on: :create
  validate :task_file_validation_on_update, on: :update
  after_save :create_tasks
  validates_presence_of :label

  def finished_task_results
    TaskResult.joins(:task).where("tasks.task_set_id = ?", id).all
  end

  def create_tasks
    if not @data.nil? and errors.empty?
      tasks.delete_all
      @data.each do |d|
        tasks.create(yaml_data: d)
      end
    end
  end

  def task_file_validation_on_update
    if task_file.nil?
      return true
    else
      return task_file_validation
    end
  end

  def task_file_validation
    @data = nil

    # file must not be nil
    if task_file.nil?
      errors.add(:task_file, 'The file is not selected')
      return false
    end

    # file must be YAML
    begin
      @data = YAML.load(task_file.read)
    rescue => ex
      errors.add(:task_file, ex.message)
      return false
    end

    # the root must be Array
    unless Array === @data
      errors.add(:task_file, 'The root must be Array')
      return false
    end

    # elements under the root must be Hash
    @data.each_with_index do |d, idx|
      unless Hash === d
        errors.add(:task_file, "#{idx+1}-th element under the root must be Hash")
      end
    end
    return false unless errors.empty?

    # elements under the root must include the same key set
    keyset = nil
    @data.each_with_index do |d, idx|
      if keyset.nil?
        keyset = Set.new(d.keys)
      else
        unless keyset == Set.new(d.keys)
          errors.add(:task_file, "#{idx+1}-th element under the root contains different keys")
        end
      end
    end
    return false unless errors.empty?
  end

end
