class BehaviorsController < ApplicationController
  def create
    @behavior = Behavior.new(behavior_params)
    @behavior.user_id = current_user.id
    @behavior.task_id = params[:task_id]
    respond_to do |format|
      if @behavior.save
        format.json { render json: @behavior.created_at, status: :created }
      else
        format.json { render json: @behavior.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def behavior_params
      params.require(:behavior).permit(:status)
    end
end
