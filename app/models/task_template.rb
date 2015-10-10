class TaskTemplate < ActiveRecord::Base
  belongs_to :user
  has_many :task_sets, dependent: :destroy
  validate :liquid_compatible
  validates_presence_of :label, :title_template

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
      return tmp.render
    rescue => ex
      errors.add(attr, "is invalid: #{ex.message}")
      return nil
    end
  end

end
