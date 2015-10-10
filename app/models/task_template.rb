class TaskTemplate < ActiveRecord::Base
  belongs_to :user
  has_many :task_sets
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

end
