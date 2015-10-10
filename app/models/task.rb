class Task < ActiveRecord::Base
  belongs_to :task_set
  has_many :task_results
  serialize :yaml_data

  def render(template)
    return Liquid::Template.parse(template).render(yaml_data)
  end

  def variables
    template = task_set.task_template.form_template
    htmltext = Liquid::Template.parse(template).render(yaml_data)
    doc = Nokogiri::HTML.parse(htmltext)
    result = []
    ['input', 'select', 'textarea'].each do |tagname|
      doc.xpath("//#{tagname}").each {|node| result << node.attribute('name').value}
    end
    result.uniq!
    return result
  end
end
