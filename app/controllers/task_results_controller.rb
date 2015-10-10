class TaskResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task
  DEFAULT_PARAMS = ['controller', 'utf8', 'authenticity_token',
    'action', 'commit', 'task_id']

  def create
    @task_result = current_user.task_results.build
    @task_result.task_id = params[:task_id]
    @task_result.submitted_data = task_result_params
    if @task_result.save
      redirect_to tasks_path, notice: 'Task result was recorded successfully.'
    else
      render template: 'tasks/show'
    end
  end

  def update
    @task_result = TaskResult.find(params[:id])
    if @task_result.update(submitted_data: task_result_params)
      redirect_to tasks_path, notice: 'Task result was updated successfully.'
    else
      render template: 'tasks/show'
    end
  end

  private

    def set_task
      @task = Task.find(params[:task_id])
    end

    def task_result_params
      params.permit(@task.variables)
    end

end
