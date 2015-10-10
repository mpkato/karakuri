class AssignsController < ApplicationController
  before_action :authenticate_user!

  def index
    @task_set = TaskSet.find(params[:task_set_id])
    @assign = Assign.new
  end

  def create
    @task_set = TaskSet.find(params[:task_set_id])
    @assign = Assign.new(assign_params)
    @assign.task_set_id = @task_set.id
    if @assign.save
      redirect_to task_set_assigns_path(@task_set), notice: 'Assinged successfully'
    else
      render :index
    end
  end

  def destroy
    assign = Assign.find(params[:id])
    assign.destroy!
    redirect_to task_set_assigns_path(assign.task_set), notice: 'Unassigned successfully'
  end

  private
    def assign_params
      params.require(:assign).permit(:name)
    end
end
