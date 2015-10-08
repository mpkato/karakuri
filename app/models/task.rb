class Task < ActiveRecord::Base
  belongs_to :task_template
  serialize :yaml_data

  def render(template)
    return Liquid::Template.parse(template).render(yaml_data)
  end
end
