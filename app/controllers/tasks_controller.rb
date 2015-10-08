class TasksController < ApplicationController
  def index
    @task_template = TaskTemplate.find(params[:task_template_id])
  end

  def show
    @task_template = TaskTemplate.find(params[:task_template_id])
    @task = Task.find(params[:id])
  end
end
