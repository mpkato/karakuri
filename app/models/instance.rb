class Instance < ActiveRecord::Base
  belongs_to :task
  serialize :yaml_data
end
