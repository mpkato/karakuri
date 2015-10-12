FactoryGirl.define do
  factory :task_result do
    submitted_data YAML.load("{A: '2'}")
  end
end
