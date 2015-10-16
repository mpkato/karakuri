class TaskSetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_set, only: [:show, :edit, :update, :destroy]
  before_action :set_task_template, only: [:index, :new, :create]

  # GET /task_sets
  # GET /task_sets.json
  def index
    @task_sets = @task_template.task_sets.includes(:assigned_users)
  end

  # GET /task_sets/1
  # GET /task_sets/1.json
  def show
  end

  # GET /task_sets/new
  def new
    @task_set = @task_template.task_sets.build
  end

  # GET /task_sets/1/edit
  def edit
  end

  # POST /task_sets
  # POST /task_sets.json
  def create
    @task_set = TaskSet.new(task_set_params)
    @task_set.task_template_id = @task_template.id

    respond_to do |format|
      if @task_set.save
        format.html { redirect_to task_template_task_sets_path(@task_template), 
          notice: 'Task set was successfully created.' }
        format.json { render :show, status: :created, location: @task_set }
      else
        format.html { render :new }
        format.json { render json: @task_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_sets/1
  # PATCH/PUT /task_sets/1.json
  def update
    respond_to do |format|
      if @task_set.update(task_set_params)
        format.html { redirect_to task_template_task_sets_path(@task_set.task_template),
          notice: 'Task set was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_set }
      else
        format.html { render :edit }
        format.json { render json: @task_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_sets/1
  # DELETE /task_sets/1.json
  def destroy
    @task_set.destroy
    respond_to do |format|
      format.html { redirect_to task_template_task_sets_path(@task_set.task_template), 
        notice: 'Task set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_set
      @task_set = TaskSet.find(params[:id])
    end

    def set_task_template
      @task_template = TaskTemplate.find(params[:task_template_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_set_params
      params.require(:task_set).permit(:label, :task_file)
    end
end
