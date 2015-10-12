FactoryGirl.define do
  factory :task_set do
    label { Faker::Name.title }
    task_file { fixture_file_upload("#{Rails.root}/spec/fixtures/task_sets/valid.yml") }
  end
end
