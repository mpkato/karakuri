require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let!(:other_users) {
    create_list(:user, 5)
  }
  let(:valid_session) { sign_in user }

  describe "GET #autocomplete_user_username" do
    subject(:json) { JSON.parse(response.body) } 
    it "assigns all task_sets as @task_sets" do
      get :autocomplete_user_username, {term: user.username}, valid_session
      expect(json.first["label"]).to eq(user.username)
    end
  end
end
