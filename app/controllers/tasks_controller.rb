class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @task_sets = current_user.assigned_task_sets
    @task_results = current_user.task_results.index_by(&:task_id)
  end

  def show
    @task = Task.find(params[:id])
    @task_result = @task.task_results.where(user_id: current_user.id).first
    if @task_result.nil?
      @task_result = @task.task_results.build
    end
  end
end
