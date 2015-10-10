json.array!(@task_sets) do |task_set|
  json.extract! task_set, :id, :label, :task_template_id
  json.url task_set_url(task_set, format: :json)
end
