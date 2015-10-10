require 'rails_helper'

RSpec.describe "TaskSets", type: :request do
  describe "GET /task_sets" do
    it "works! (now write some real specs)" do
      get task_sets_path
      expect(response).to have_http_status(200)
    end
  end
end
