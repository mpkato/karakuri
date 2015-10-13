class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.assigned_tasks
      .eager_load(task_set: :task_template).to_a
    @task_results = current_user.task_results.index_by(&:task_id)
  end

  def show
    @task = Task.eager_load(task_set: :task_template).find(params[:id])
    @task_result = @task.task_results.find_by(user_id: current_user.id)
    if @task_result.nil?
      @task_result = @task.task_results.build
    end
  end
end
