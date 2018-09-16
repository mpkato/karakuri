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

  let(:preview_attributes) {
    attributes_for(:task_template, user_id: user.id,
      preview_yaml_data: "{query: 'A'}") 
  }

  let(:invalid_preview_attributes) {
    attributes_for(:task_template, user_id: user.id,
      preview_yaml_data: "") 
  }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TaskTemplatesController. Be sure to keep this updated too.
  before do
    sign_in user
  end

  describe "GET #index" do
    it "assigns all task_templates as @task_templates" do
      task_template = TaskTemplate.create! valid_attributes
      get :index, params: {task_template_id: task_template.id}
      expect(assigns(:task_templates)).to eq([task_template])
    end
  end

  describe "GET #show" do
    it "assigns the requested task_template as @task_template" do
      task_template = TaskTemplate.create! valid_attributes
      get :show, params: {:id => task_template.to_param}
      expect(assigns(:task_template)).to eq(task_template)
    end
  end

  describe "GET #new" do
    it "assigns a new task_template as @task_template" do
      get :new, params: {}
      expect(assigns(:task_template)).to be_a_new(TaskTemplate)
    end
  end

  describe "GET #edit" do
    it "assigns the requested task_template as @task_template" do
      task_template = TaskTemplate.create! valid_attributes
      get :edit, params: {:id => task_template.to_param}
      expect(assigns(:task_template)).to eq(task_template)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TaskTemplate" do
        expect {
          post :create, params: {:task_template => valid_attributes}
        }.to change(TaskTemplate, :count).by(1)
      end

      it "assigns a newly created task_template as @task_template" do
        post :create, params: {:task_template => valid_attributes}
        expect(assigns(:task_template)).to be_a(TaskTemplate)
        expect(assigns(:task_template)).to be_persisted
      end

      it "redirects to the created task_template" do
        post :create, params: {:task_template => valid_attributes}
        expect(response).to redirect_to(task_templates_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved task_template as @task_template" do
        post :create, params: {:task_template => invalid_attributes}
        expect(assigns(:task_template)).to be_a_new(TaskTemplate)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:task_template => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:task_template, user_id: user.id,
          label: Faker::Job.title)
      }

      it "updates the requested task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, params: {:id => task_template.to_param, :task_template => new_attributes}
        expect{ task_template.reload }.to change{ task_template.label }.from(task_template.label).to(new_attributes[:label])
      end

      it "assigns the requested task_template as @task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, params: {:id => task_template.to_param, :task_template => new_attributes}
        expect(assigns(:task_template)).to eq(task_template)
      end

      it "redirects to the task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, params: {:id => task_template.to_param, :task_template => new_attributes}
        expect(response).to redirect_to(task_templates_path)
      end
    end

    context "with invalid params" do
      it "assigns the task_template as @task_template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, params: {:id => task_template.to_param, :task_template => invalid_attributes}
        expect(assigns(:task_template)).to eq(task_template)
      end

      it "re-renders the 'edit' template" do
        task_template = TaskTemplate.create! valid_attributes
        put :update, params: {:id => task_template.to_param, :task_template => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task_template" do
      task_template = TaskTemplate.create! valid_attributes
      expect {
        delete :destroy, params: {:id => task_template.to_param}
      }.to change(TaskTemplate, :count).by(-1)
    end

    it "redirects to the task_templates list" do
      task_template = TaskTemplate.create! valid_attributes
      delete :destroy, params: {:id => task_template.to_param}
      expect(response).to redirect_to(task_templates_path)
    end
  end

  describe "POST #preview" do
    context "with valid attributes" do
      it "renders form_template" do
        post :preview, params: {:task_template => preview_attributes}
        expect(response.body).to start_with("<p>「A」")
      end
    end
    context "with invalid attributes" do
      it "renders 'Syntax error *'" do
        post :preview, params: {:task_template => invalid_preview_attributes}
        expect(response.body).to start_with("Syntax error")
      end
    end
  end

  describe "PATCH #preview" do
    context "with valid attributes" do
      it "renders form_template" do
        patch :preview, params: {:task_template => preview_attributes}
        expect(response.body).to start_with("<p>「A」")
      end
    end
    context "with invalid attributes" do
      it "renders 'Syntax error *'" do
        patch :preview, params: {:task_template => invalid_preview_attributes}
        expect(response.body).to start_with("Syntax error")
      end
    end
  end

end
