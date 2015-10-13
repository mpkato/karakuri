class TaskTemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_template, only: [:show, :edit, :update, :destroy]

  # GET /task_templates
  # GET /task_templates.json
  def index
    @task_templates = current_user.task_templates
  end

  # GET /task_templates/1
  # GET /task_templates/1.json
  def show
  end

  # GET /task_templates/new
  def new
    @task_template = TaskTemplate.new
  end

  # GET /task_templates/1/edit
  def edit
  end

  # POST /task_templates
  # POST /task_templates.json
  def create
    @task_template = TaskTemplate.new(task_template_params)
    @task_template.user = current_user
    respond_to do |format|
      if not params[:preview] and @task_template.save
        format.html { redirect_to task_templates_path, notice: 'Task template was successfully created.' }
        format.json { render :show, status: :created, location: @task_template }
      else
        format.html { render :new }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_templates/1
  # PATCH/PUT /task_templates/1.json
  def update
    respond_to do |format|
      if @task_template.update(task_template_params)
        format.html { redirect_to task_templates_path, notice: 'Task template was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_template }
      else
        format.html { render :edit }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_templates/1
  # DELETE /task_templates/1.json
  def destroy
    @task_template.destroy
    respond_to do |format|
      format.html { redirect_to task_templates_url, notice: 'Task template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_template
      @task_template = TaskTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_template_params
      params.require(:task_template)
        .permit(:label, :title_template, :form_template, :preview_yaml_data)
    end
end
