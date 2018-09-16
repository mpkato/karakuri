class AssignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assign, only: [:show, :destroy]

  def index
    @task_set = TaskSet.includes(assigns: :user).find(params[:task_set_id])
    @assigns = @task_set.assigns
    @finished_task_results = @task_set.finished_task_results.group_by(&:user_id)
    @assign = Assign.new
  end

  def show
    @tasks = @assign.task_set.tasks
    @finished_task_results = @assign.user.finished_task_results(@assign.task_set).index_by(&:task_id)
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
    @assign.destroy!
    redirect_to task_set_assigns_path(@assign.task_set), notice: 'Unassigned successfully'
  end

  def download
    @assign = Assign.find(params[:assign_id])
    @task_results = TaskResult.where(user_id: @assign.user_id)
      .joins(:task).merge(Task.where(task_set_id: @assign.task_set_id))
    respond_to do |format|
      format.html { redirect_to :action => 'download', :format => 'json' }
      format.json { render }
    end
  end

  private
    def set_assign
      @assign = Assign.find(params[:id])
    end
    def assign_params
      params.require(:assign).permit(:name)
    end
end
