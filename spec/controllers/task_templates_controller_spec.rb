require 'rails_helper'

RSpec.describe TaskTemplatesController, type: :controller do
  let(:user) {
    create(:user)
  }

  let(:valid_attributes) {
    attributes_for(:task_template, user_id: user.id)
  }

  let(:invalid_attributes) {
    attributes_for(:task_template, user_id: user.id,
      label: "")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TaskTemplatesController. Be sure to keep this updated too.
  let(:valid_session) { sign_in user }

  describe "GET #index" do
    it "assigns all task_templates as @task_templates" do
      task_template = TaskTemplate.create! valid_attributes
      get :index, {task_template_id: task_template.id}, valid_session
      expect(assigns(:task_templates)).to eq([task_template])
    end
  end

  describe "GET #show" do
    it "assigns the requested task_template as @task_template" do
      task_template = TaskTemplate.create! valid_attributes
      get :show, {:id => task_template.to_param}, valid_session
      expect(assigns(:task_template)).to eq(task_template)
    end
  end

  describe "GET #new" do
    it "assigns a new task_template as @task_template" do
      get :new, {}, valid_session
      expect(assigns(:task_template)).to be_a_new(TaskTemplate)
    end
  end

  describe "GET #edit" do
    it "assigns the requested task_template as @task_template" do
      task_template = TaskTemplate.create! valid_attributes
      get :edit, {:id => task_template.to_param}, valid_session
      expect(assigns(:task_template)).to eq(task_template)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TaskTemplate" do
        expect {
          post :create, {:task_template => valid_attributes}, valid_session
        }.to change(TaskTemplate, :count).by(1)
      end

      it "assigns a newly created task_template as @task_template" do
        post :create, {:task_template => valid_attributes}, valid_session
        expect(assigns(:task_template)).to be_a(TaskTemplate)
        expect(assigns(:task_template)).to be_persisted
      end

      it "redirects to the created task_template" do
        post :create, {:task_template => valid_attributes}, valid_session
        expect(response).to redirect_to(task_templates_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved task_template as @task_template" do
        post :create, {:task_template => invalid_attributes}, valid_session
        expect(assigns(:task_template)).to be_a_new(TaskTemplate)
      end

      it "re-renders the 'new' template" do
        post :create, {:task_template => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:task_template, user_id: user.id,
          label: Faker::Name.title)
      }

      it "updates the requested task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, {:id => task_template.to_param, :task_template => new_attributes}, valid_session
        expect{ task_template.reload }.to change{ task_template.label }.from(task_template.label).to(new_attributes[:label])
      end

      it "assigns the requested task_template as @task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, {:id => task_template.to_param, :task_template => new_attributes}, valid_session
        expect(assigns(:task_template)).to eq(task_template)
      end

      it "redirects to the task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, {:id => task_template.to_param, :task_template => new_attributes}, valid_session
        expect(response).to redirect_to(task_templates_path)
      end
    end

    context "with invalid params" do
      it "assigns the task_template as @task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, {:id => task_template.to_param, :task_template => invalid_attributes}, valid_session
        expect(assigns(:task_template)).to eq(task_template)
      end

      it "re-renders the 'edit' template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, {:id => task_template.to_param, :task_template => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task_template" do
      task_template = TaskTemplate.create! valid_attributes
      expect {
        delete :destroy, {:id => task_template.to_param}, valid_session
      }.to change(TaskTemplate, :count).by(-1)
    end

    it "redirects to the task_templates list" do
      task_template = TaskTemplate.create! valid_attributes
      delete :destroy, {:id => task_template.to_param}, valid_session
      expect(response).to redirect_to(task_templates_path)
    end
  end

end
