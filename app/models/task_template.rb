class TaskTemplate < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  validate :liquid_compatible
  validates_presence_of :title_template

  def liquid_compatible
    [:title_template, :form_template].each do |attr|
      begin
        Liquid::Template.parse(self[attr])
      rescue => ex
        errors.add(attr, "is invalid: #{ex.message}")
      end
    end
  end

  def upload(file)
    data, errors = task_file_validation(file)
    if errors.empty?
      tasks.delete_all
      data.each do |d|
        tasks.create(yaml_data: d)
      end
    end
    return errors
  end

  def task_file_validation(file)
    data = nil
    errors = []

    # file must not be nil
    if file.nil?
      errors << 'File is not selected.'
      return [data, errors]
    end

    # file must be YAML
    begin
      data = YAML.load(file.read)
    rescue => ex
      errors << ex.message
      return [data, errors]
    end

    # the root must be Array
    unless Array === data
      errors << 'The root must be Array'
      return [data, errors]
    end

    # elements under the root must be Hash
    data.each_with_index do |d, idx|
      unless Hash === d
        errors << "#{idx+1}-th element under the root must be Hash"
      end
    end
    return [data, errors] unless errors.empty?

    # elements under the root must include the same key set
    keyset = nil
    data.each_with_index do |d, idx|
      if keyset.nil?
        keyset = Set.new(d.keys)
      else
        unless keyset == Set.new(d.keys)
          errors << "#{idx+1}-th element under the root contains different keys"
        end
      end
    end

    return [data, errors]
  end

end
