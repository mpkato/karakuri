require 'rails_helper'

RSpec.describe Assign, type: :model do
  let(:user) {
    create(:user)
  }

  let(:task_template) {
    create(:task_template, user_id: user.id)
  }

  let(:task_set) {
    create(:task_set, task_template_id: task_template.id)
  }

  describe "#create" do
    subject(:assign) { Assign.new(attributes) }
    context "with valid attributes" do
      let(:attributes) { {task_set_id: task_set.id, name: user.username} }
      it {
        expect(assign).to be_valid
        expect(assign.user_id).not_to be_nil
      }
    end

    context "with empty task_set id" do
      let(:attributes) { {task_set_id: nil, name: user.username} }
      it "is invalid due to task_set_id" do
        expect(assign).to be_invalid
        expect(assign.errors[:task_set_id].first).to be_present
      end
    end

    context "with empty name" do
      let(:attributes) { {task_set_id: task_set.id, name: ""} }
      it "is invalid due to name" do
        expect(assign).to be_invalid
        expect(assign.errors[:name].first).to be_present
      end
    end

    context "with invalid name" do
      let(:attributes) { {task_set_id: task_set.id, name: user.username + "-"} }
      it "is invalid due to name not found" do
        expect(assign).to be_invalid
        expect(assign.errors[:name].first).to end_with("was not found")
      end
    end

    context "with multiple assigns" do
      let(:attributes) { {task_set_id: task_set.id, name: user.username} }
      let!(:another) { Assign.create(attributes) }
      it "is invalid due to multiple assigns" do
        expect(assign).to be_invalid
        expect(assign.errors[:name].first).to end_with("has already been assigned")
      end
    end
  end

  describe "#destroy" do
    let!(:assign) { create(:assign, task_set_id: task_set.id, name: user.username) }
    it { expect{assign.destroy}.to change{ Assign.count }.by(-1) }
    it { expect{assign.destroy}.to change{ User.count }.by(0).and change{ Task.count }.by(0) }
  end

end
