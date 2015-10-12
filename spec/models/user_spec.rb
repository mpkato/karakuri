require 'rails_helper'

RSpec.describe User, type: :model do
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

  describe "#assigned_tasks" do
    let!(:another_user) { create(:user) }
    it { expect{ Assign.create(task_set_id: task_set.id, name: user.username) }.to\
      change{user.assigned_tasks.size}.by(task_set.tasks.size).and\
      change{another_user.assigned_tasks.size}.by(0) }
  end

  describe "#next_task" do
    let!(:another_task_set) { create(:task_set, task_template_id: task_template.id) }
    let!(:current_task) { create(:task, task_set_id: task_set.id) }
    let!(:wrong_task) { create(:task, task_set_id: another_task_set.id) }
    let!(:next_task) { create(:task, task_set_id: task_set.id) }
    before do
      Assign.create(task_set_id: task_set.id, name: user.username)
      Assign.create(task_set_id: another_task_set.id, name: user.username)
    end
    it { expect(user.next_task(current_task.id)).to eq(next_task) }
    it { expect(user.next_task(next_task.id)).to be_nil }
  end

  describe "#finished_task_results" do
    let!(:another_user) { create(:user) }
    let!(:another_task_set) { create(:task_set, task_template_id: task_template.id) }
    before do
      Assign.create(task_set_id: task_set.id, name: user.username)
      Assign.create(task_set_id: another_task_set.id, name: user.username)
      Assign.create(task_set_id: task_set.id, name: another_user.username)
    end
    it { expect{ create(:task_result, task_id: task.id, user_id: user.id) }.to\
      change{user.finished_task_results(task_set).size}.by(1).and\
      change{user.finished_task_results(another_task_set).size}.by(0).and\
      change{another_user.finished_task_results(task_set).size}.by(0) }
  end

  describe "#active_time_points" do
    let!(:another_user) { create(:user) }
    let!(:another_task_set) { create(:task_set, task_template_id: task_template.id) }
    before do
      Assign.create(task_set_id: task_set.id, name: user.username)
      Assign.create(task_set_id: another_task_set.id, name: user.username)
      Assign.create(task_set_id: task_set.id, name: another_user.username)
    end
    it { expect{ Behavior.create(task_id: task.id, user_id: user.id, status: 0) }.to\
      change{user.active_time_points(task_set).size}.by(1).and\
      change{user.active_time_points(another_task_set).size}.by(0).and\
      change{another_user.active_time_points(task_set).size}.by(0) }
  end

  describe "#estimated_work_time" do
    before do
      Assign.create(task_set_id: task_set.id, name: user.username)
      it { expect{ Behavior.create(task_id: task.id, user_id: user.id, status: 0) }.to\
        change{user.estimated_work_time(task_set)}.by(5) }
    end
  end

end
