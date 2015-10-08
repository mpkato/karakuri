class Task < ActiveRecord::Base
  belongs_to :user
  has_many :instances
  validate :liquid_compatible

  def liquid_compatible
    begin
      Liquid::Template.parse(html_form)
    rescue => ex
      errors.add(:html_form, "is invalid: #{ex.message}")
    end
  end

  def upload(file)
    data, errors = instance_file_validation(file)
    if errors.empty?
      instances.delete_all
      data.each do |d|
        instances.create(yaml_data: d)
      end
    end
    return errors
  end

  def instance_file_validation(file)
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
