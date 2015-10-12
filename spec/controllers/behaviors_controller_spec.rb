require 'rails_helper'

RSpec.describe BehaviorsController, type: :controller do
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

  let(:valid_attributes) {
    attributes_for(:behavior, task_id: task.id, user_id: user.id)
  }

  let(:invalid_attributes) {
    attributes_for(:behavior, status: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BehaviorsController. Be sure to keep this updated too.
  let(:valid_session) { sign_in user }

  describe "GET #index" do
    it "is not found" do
      behavior = Behavior.create! valid_attributes
      expect{get :index, {task_id: task.id}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "GET #show" do
    it "is not found" do
      behavior = Behavior.create! valid_attributes
      expect{get :show, {:id => behavior.to_param}, valid_session}.to\
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
      behavior = Behavior.create! valid_attributes
      expect{get :edit, {:id => behavior.to_param}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Behavior" do
        expect {
          post :create, {task_id: task.id,
          :behavior => valid_attributes, format: :json}, valid_session
        }.to change(Behavior, :count).by(1)
      end

      it "assigns a newly created behavior as @behavior" do
        post :create, {task_id: task.id,
          :behavior => valid_attributes, format: :json}, valid_session
        expect(assigns(:behavior)).to be_a(Behavior)
        expect(assigns(:behavior)).to be_persisted
      end

      it "respond :created" do
        post :create, {task_id: task.id,
          :behavior => valid_attributes, format: :json}, valid_session
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved behavior as @behavior" do
        post :create, {task_id: task.id,
          :behavior => invalid_attributes, format: :json}, valid_session
        expect(assigns(:behavior)).to be_a_new(Behavior)
      end

      it "respond :unprocessable_entity" do
        post :create, {task_id: task.id,
          :behavior => invalid_attributes, format: :json}, valid_session
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    let(:another_task) { create(:task, task_set_id: task_set.id) }
    let(:new_attributes) {
      attributes_for(:behavior, user_id: user.id, task_id: another_task.id)
    }
    it "is not found" do
      behavior = Behavior.create! valid_attributes
      expect{put :update, {:id => behavior.to_param, 
        :behavior => new_attributes}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "DELETE #destroy" do
    it "is not found" do
      behavior = Behavior.create! valid_attributes
      expect{delete :destroy, {:id => behavior.to_param}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end
end
