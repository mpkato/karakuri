class AssignsController < ApplicationController
  def create
    user = User.find_by(username: params[:assign][:name])
    task_set = TaskSet.find(params[:task_set_id])
    if user.nil?
      redirect_to task_set_path(task_set), alert: 'User not found'
    else
      user.assigned_task_sets << task_set
      redirect_to task_set_path(task_set), notice: 'Assinged successfully'
    end
  end

  def destroy
    assign = Assign.find(params[:id])
    assign.destroy
    redirect_to task_set_path(assign.task_set), notice: 'Unassigned successfully'
  end
end
