require 'rails_helper'

RSpec.describe TaskResult, type: :model do
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

  describe "#create" do
    subject(:task_result) { TaskResult.new(attributes) }
    context "with valid attributes" do
      let(:attributes) { {task_id: task.id, user_id: user.id,
        submitted_data: YAML.load("{A: '1'}")} }
      it { expect(task_result).to be_valid }
    end
    
    context "with empty user_id" do
      let(:attributes) { {task_id: task.id, user_id: nil,
        submitted_data: YAML.load("{A: '1'}")} }
      it "is invalid due to user_id" do 
        expect(task_result).to be_invalid
        expect(task_result.errors[:user_id].first).to be_present
      end
    end
    
    context "with empty task_id" do
      let(:attributes) { {task_id: nil, user_id: user.id,
        submitted_data: YAML.load("{A: '1'}")} }
      it "is invalid due to user_id" do 
        expect(task_result).to be_invalid
        expect(task_result.errors[:task_id].first).to be_present
      end
    end
    
    context "with invalid submitted_data" do
      shared_examples "is invalid due to submitted_data" do
        it {
          expect(task_result).to be_invalid
          expect(task_result.errors[reason].first).to be_present
        }
      end
      
      context "nil" do
        let(:attributes) { {task_id: task.id, user_id: user.id,
          submitted_data: nil} }
        let(:reason) { :submitted_data }
        it_behaves_like "is invalid due to submitted_data"
      end
      
      context "empty" do
        let(:attributes) { {task_id: task.id, user_id: user.id,
          submitted_data: ""} }
        let(:reason) { :submitted_data }
        it_behaves_like "is invalid due to submitted_data"
      end
      
      context "string" do
        let(:attributes) { {task_id: task.id, user_id: user.id,
          submitted_data: "A"} }
        let(:reason) { :submitted_data }
        it_behaves_like "is invalid due to submitted_data"
      end

      context "lacking of required variables" do
        let(:attributes) { {task_id: task.id, user_id: user.id,
          submitted_data: YAML.load("{B: '1'}")} }
        let(:reason) { :A }
        it_behaves_like "is invalid due to submitted_data"
      end
    end
    
  end
end
