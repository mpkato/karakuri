require 'rails_helper'

RSpec.describe TaskResultsController, type: :controller do

  let(:user) {
    create(:user)
  }

  let(:task_template) {
    create(:task_template, user_id: user.id)
  }

  let(:task_set) {
    create(:task_set, task_template_id: task_template.id)
  }

  let(:task) {
    create(:task, task_set_id: task_set.id)
  }

  let(:attributes) {
    attributes_for(:task_result, task_id: task.id, user_id: user.id)
  }

  let(:valid_session) { sign_in user }

  describe "GET #index" do
    it "is not found" do
      task_result = TaskResult.create! attributes
      expect{get :index, {task_id: task.id}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "GET #show" do
    it "is not found" do
      task_result = TaskResult.create! attributes
      expect{get :show, {:id => task_result.to_param}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "GET #new" do
    it "is not found" do
      expect{get :new, {task_id: task.id}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "GET #edit" do
    it "is not found" do
      task_result = TaskResult.create! attributes
      expect{get :edit, {:id => task_result.to_param}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) {{task_id: task.id, task_result: attributes, A: 1}}
      it "creates a new TaskResult" do
        expect {
          post :create, valid_attributes, valid_session
        }.to change(TaskResult, :count).by(1)
      end

      it "assigns a newly created task_result as @task_result" do
        post :create, valid_attributes, valid_session
        expect(assigns(:task_result)).to be_a(TaskResult)
        expect(assigns(:task_result)).to be_persisted
      end

      context "without next" do
        it "redirects to the task list" do
          post :create, valid_attributes, valid_session
          expect(response).to redirect_to(tasks_path)
        end
      end

      context "with next" do
        before do
          Assign.create(name: user.username, task_set_id: task_set.id)
        end
        it "redirects to the next task" do
          attrs = valid_attributes.clone
          another_task = create(:task, task_set_id: task_set.id)
          attrs[:next] = true
          post :create, attrs, valid_session
          expect(response).to redirect_to(task_path(another_task))
        end
      end

    end

    context "with invalid params" do
      let(:invalid_attributes) {{task_id: task.id, task_result: attributes}}
      it "assigns a newly created but unsaved task_result as @task_result" do
        post :create, invalid_attributes, valid_session
        expect(assigns(:task_result)).to be_a_new(TaskResult)
      end

      it "re-renders the 'new' template" do
        post :create, invalid_attributes, valid_session
        expect(response).to render_template("tasks/show")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let!(:task_result) { TaskResult.create! attributes }
      let(:valid_attributes) {{task_id: task.id, id: task_result.id, 
        task_result: attributes, A: 3}}

      it "updates the requested task_result" do
        put :update, valid_attributes, valid_session
        expect{ task_result.reload }.to change{ task_result.submitted_data["A"] }
      end

      it "assigns the requested task_result as @task_result" do
        put :update, valid_attributes, valid_session
        expect(assigns(:task_result)).to eq(task_result)
      end

      it "redirects to the task_result" do
        put :update, valid_attributes, valid_session
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid params" do
      let!(:task_result) { TaskResult.create! attributes }
      let(:invalid_attributes) {{task_id: task.id, id: task_result.id, 
        task_result: attributes, B: 3}}
      it "assigns the task_result as @task_result" do
        put :update, invalid_attributes, valid_session
        expect(assigns(:task_result)).to eq(task_result)
      end

      it "re-renders the 'edit' template" do
        put :update, invalid_attributes, valid_session
        expect(response).to render_template("tasks/show")
      end
    end
  end

  describe "DELETE #destroy" do
    it "is not found" do
      task_result = TaskResult.create! attributes
      expect{delete :destroy, {:id => task_result.to_param}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end
end
