class InstancesController < ApplicationController
  def index
    @task = Task.find(params[:task_id])
  end

  def show
    @task = Task.find(params[:task_id])
    @instance = Instance.find(params[:id])
  end
end
