class TaskTemplate < ActiveRecord::Base
  belongs_to :user
  has_many :task_sets, dependent: :destroy
  validate :liquid_compatible
  validates_presence_of :label, :title_template, :user_id
  attr_accessor :preview_yaml_data

  def liquid_compatible
    [:title_template, :form_template].each do |attr|
      begin
        Liquid::Template.parse(self[attr])
      rescue => ex
        errors.add(attr, "is invalid: #{ex.message}")
      end
    end
  end

  def preview
    begin
      tmp = Liquid::Template.parse(form_template)
      yaml_data = YAML.load(preview_yaml_data)
      return tmp.render(yaml_data)
    rescue Liquid::SyntaxError => ex
      return "Syntax error in the form template"
    rescue Psych::SyntaxError, Liquid::ArgumentError => ex
      return "Syntax error in the preview yaml data"
    end
  end

end
