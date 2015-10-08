class AssignedTasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @task_templates = current_user.assigned_task_templates
  end

  def show
    @task = Task.find(params[:id])
  end
end
