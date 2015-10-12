require 'rails_helper'

RSpec.describe Behavior, type: :model do
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
    subject(:behavior) { Behavior.new(attributes) }
    context "with valid attributes" do
      let(:attributes) { {task_id: task.id, user_id: user.id, status: 0} }
      it { expect(behavior).to be_valid }
    end

    context "with empty user_id" do
      let(:attributes) { {task_id: task.id, user_id: nil, status: 0} }
      it "is invalid due to user_id" do
        expect(behavior).to be_invalid
        expect(behavior.errors[:user_id].first).to be_present
      end
    end

    context "with empty task_id" do
      let(:attributes) { {task_id: nil, user_id: user.id, status: 0} }
      it "is invalid due to user_id" do
        expect(behavior).to be_invalid
        expect(behavior.errors[:task_id].first).to be_present
      end
    end

    context "with empty status" do
      let(:attributes) { {task_id: task.id, user_id: user.id, status: nil} }
      it "is invalid due to status" do
        expect(behavior).to be_invalid
        expect(behavior.errors[:status].first).to be_present
      end
    end
  end
end
