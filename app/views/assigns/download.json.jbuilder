json.array!(@task_results) do |task_result|
  json.extract! task_result, :id, :created_at, :updated_at
  json.user @assign.user.username
  json.result task_result.submitted_data
  json.task do
    json.id task_result.task.id
    json.label task_result.task.task_set.label
    json.data task_result.task.yaml_data
  end
end
