class AssignedTasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @task_sets = current_user.assigned_task_sets
  end

  def show
    @task = Task.find(params[:id])
    @task_result = @task.task_results.build
  end
end
