require 'rails_helper'

RSpec.describe Task, type: :model do
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
    subject(:task) { Task.new(attributes) }
    context "with valid attributes" do
      let(:attributes) { {task_set_id: task_set.id, yaml_data: "[1, 2]"} }
      it { expect(task).to be_valid }
    end

    context "with empty task_set id" do
      let(:attributes) { {task_set_id: nil, yaml_data: "[1, 2]"} }
      it "is invalid due to task_set_id" do
        expect(task).to be_invalid
        expect(task.errors[:task_set_id].first).to be_present
      end
    end

    context "with empty yaml_data" do
      let(:attributes) { {task_set_id: task_set.id, yaml_data: nil} }
      it "is invalid due to yaml_data" do
        expect(task).to be_invalid
        expect(task.errors[:yaml_data].first).to be_present
      end
    end
  end

  describe "#render" do
    let(:task) { task_set.tasks.create(attributes_for(:task)) }
    context "for simple rendering" do
      subject(:render_result) { task.render("{{ qid }}") }
      it { expect(render_result).to eq(task.yaml_data["qid"]) }
    end

    context "for rendering with loop" do
      subject(:render_result) { task.render("{% for i in iunits %}{{ i[0] }}/{{ i[1] }}{% endfor %}") }
      let(:iunit) { task.yaml_data["iunits"].first }
      it { expect(render_result).to eq("#{iunit[0]}/#{iunit[1]}") }
    end
  end

  describe "#variables" do
    context "for simple case" do
      let(:task) { task_set.tasks.create(attributes_for(:task)) }
      subject(:variables) { task.variables }
      it { expect(variables).to match_array(["A"]) }
    end

    context "for complicated case" do
      let(:task_template_complex) { create(:task_template, :complex, user_id: user.id) }
      let(:task_set_complex) { create(:task_set, task_template_id: task_template_complex.id) }
      subject(:variables) { create(:task, task_set_id: task_set_complex.id).variables }
      it { expect(variables).to match_array(["radio", "text", "hidden", "select", "textarea"]) }
    end
  end

end
