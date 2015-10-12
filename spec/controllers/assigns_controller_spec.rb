require 'rails_helper'

RSpec.describe AssignsController, type: :controller do
  let(:user) {
    create(:user)
  }

  let(:task_template) {
    create(:task_template, user_id: user.id)
  }

  let(:task_set) {
    create(:task_set, task_template_id: task_template.id)
  }

  let(:valid_attributes) {
    attributes_for(:assign, task_set_id: task_set.id, name: user.username)
  }

  let(:invalid_attributes) {
    attributes_for(:assign, task_set_id: task_set.id, name: "")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AssignsController. Be sure to keep this updated too.
  let(:valid_session) { sign_in user }

  describe "GET #index" do
    it "assigns all assigns as @assigns" do
      assign = Assign.create! valid_attributes
      get :index, {task_set_id: task_set.id}, valid_session
      expect(assigns(:assigns)).to eq([assign])
    end
  end

  describe "GET #show" do
    it "assigns the requested assign as @assign" do
      assign = Assign.create! valid_attributes
      get :show, {:id => assign.to_param}, valid_session
      expect(assigns(:assign)).to eq(assign)
    end
  end

  describe "GET #new" do
    it "is not found" do
      expect{get :new, {task_set_id: task_set.id}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "GET #edit" do
    it "is not found" do
      assign = Assign.create! valid_attributes
      expect{get :edit, {:id => assign.to_param}, valid_session}.to\
        raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Assign" do
        expect {
          post :create, {task_set_id: task_set.id,
          :assign => valid_attributes}, valid_session
        }.to change(Assign, :count).by(1)
      end

      it "assigns a newly created assign as @assign" do
        post :create, {task_set_id: task_set.id,
          :assign => valid_attributes}, valid_session
        expect(assigns(:assign)).to be_a(Assign)
        expect(assigns(:assign)).to be_persisted
      end

      it "redirects to the created assign" do
        post :create, {task_set_id: task_set.id,
          :assign => valid_attributes}, valid_session
        expect(response).to redirect_to(task_set_assigns_path(task_set))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved assign as @assign" do
        post :create, {task_set_id: task_set.id,
          :assign => invalid_attributes}, valid_session
        expect(assigns(:assign)).to be_a_new(Assign)
      end

      it "re-renders the 'new' template" do
        post :create, {task_set_id: task_set.id,
          :assign => invalid_attributes}, valid_session
        expect(response).to render_template("index")
      end
    end
  end

  describe "PUT #update" do
    let(:another_task_set) { create(:task_set, task_template_id: task_template.id) }
    let(:new_attributes) {
      attributes_for(:assign, user_id: user.id, task_set_id: another_task_set.id)
    }
    it "is not found" do
      assign = Assign.create! valid_attributes
      expect{put :update, {:id => assign.to_param, 
        :assign => new_attributes}, valid_session}.to\
      raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested assign" do
      assign = Assign.create! valid_attributes
      expect {
        delete :destroy, {:id => assign.to_param}, valid_session
      }.to change(Assign, :count).by(-1)
    end

    it "redirects to the assigns list" do
      assign = Assign.create! valid_attributes
      delete :destroy, {:id => assign.to_param}, valid_session
      expect(response).to redirect_to(task_set_assigns_path(task_set))
    end
  end


end
