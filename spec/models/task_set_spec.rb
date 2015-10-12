require 'rails_helper'

RSpec.describe TaskSet, type: :model do
  let(:user) {
    create(:user)
  }

  let(:task_template) {
    create(:task_template, user_id: user.id)
  }

  describe "#validate" do
    subject(:task_set) do
      TaskSet.new(attributes)
    end

    context "with valid attributes" do
      let(:attributes) { 
        attributes_for(:task_set, task_template_id: task_template.id)
      }
      it { expect(task_set).to be_valid }
    end

    context "with empty label" do
      let(:attributes) { 
        attributes_for(:task_set, task_template_id: task_template.id,
          label: "")
      }
      it "is invalid due to label" do
        expect(task_set).to be_invalid
        expect(task_set.errors[:label]).to be_present
      end
    end

    context "with empty task_template_id" do
      let(:attributes) { 
        attributes_for(:task_set, task_template_id: nil)
      }
      it "is invalid due to task_template_id" do
        expect(task_set).to be_invalid
        expect(task_set.errors[:task_template_id]).to be_present
      end
    end

    context "with empty task_file" do
      let(:attributes) { 
        attributes_for(:task_set, task_template_id: task_template.id,
          task_file: "")
      }
      it "is invalid due to task_file" do
        expect(task_set).to be_invalid
        expect(task_set.errors[:task_file]).to be_present
      end
    end

  end

  describe "#task_file_validation" do
    subject(:task_set) do
      build(:task_set, task_file: task_file, task_template_id: task_template.id)
    end

    context "with valid task_file" do
      let(:task_file) { fixture_file_upload("/task_sets/valid.yml") }
      it { expect(task_set).to be_valid }
    end

    context "with invalid task_file" do
      subject(:task_file_error) { task_set.errors[:task_file].first }

      context "of non-YAML" do
        let(:task_file) { fixture_file_upload("/task_sets/nonyaml.yml") }
        it "raises YAML parse error" do
          expect(task_set).to be_invalid
          expect(task_file_error).to be_present
        end
      end

      context "starting with hash" do
        let(:task_file) { fixture_file_upload("/task_sets/hash_root.yml") }
        it "raises 'The root must be Array'" do
          expect(task_set).to be_invalid
          expect(task_file_error).to eq("The root must be Array")
        end
      end

      context "starting with Array-Array" do
        let(:task_file) { fixture_file_upload("/task_sets/array_array.yml") }
        it "raises '* element under the root must be Hash'" do
          expect(task_set).to be_invalid
          expect(task_set.errors[:task_file].first).to end_with("element under the root must be Hash")
        end
      end

      context "containing different keys" do
        let(:task_file) { fixture_file_upload("/task_sets/different_keys.yml") }
        it "raises '* element under the root contains different keys'" do
          expect(task_set).to be_invalid
          expect(task_set.errors[:task_file].first).to\
            end_with("element under the root contains different keys")
        end
      end

    end

  end

  describe "#task_file_validation_on_update" do
    subject(:task_set) do
      create(:task_set, task_template_id: task_template.id)
    end

    context "with valid attributes" do

      it "updates the label" do
        new_label = Faker::Name.title
        expect(task_set.update(label: new_label, task_file: nil)).to be_truthy
        expect(task_set.reload.label).to eq(new_label)
      end

      context "with the same file" do
        it "creates exactly the same tasks" do
          old_tasks = task_set.tasks.map {|t| t.yaml_data["qid"] }
          new_attrs = { task_file: fixture_file_upload("/task_sets/valid.yml") }
          expect(task_set.update(new_attrs)).to be_truthy
          expect(task_set.tasks.map {|t| t.yaml_data["qid"]}).to match_array(old_tasks)
        end
      end

      context "with a different task_file" do
        it "creates different tasks" do
          old_tasks = task_set.tasks.map {|t| t.yaml_data["qid"] }
          new_attrs = { task_file: fixture_file_upload("/task_sets/another_valid.yml") }
          expect(task_set.update(new_attrs)).to be_truthy
          expect(task_set.tasks.map {|t| t.yaml_data["qid"]}).not_to match_array(old_tasks)
        end
      end

    end

    context "with invalid attributes" do
      it { expect(task_set.update(label: "")).to be_falsey }
      it { expect(task_set.update(task_file:
        fixture_file_upload("/task_sets/array_array.yml"))).to be_falsey }
    end
  end

  describe "#create_tasks" do
    
    context "in create" do
      subject(:tasks) do
        create(:task_set, task_template_id: task_template.id).tasks
      end

      it { expect(tasks.size).to eq(6) }
      it { expect(tasks.first.yaml_data["qid"]).to eq("MC2-J-0001") }
      it { expect(tasks.last.yaml_data["qid"]).to eq("MC2-J-0002") }
    end

    context "in update" do
      subject(:task_set) do
        create(:task_set, task_template_id: task_template.id)
      end

      context "with valid task file" do
        it "does change the tasks" do
          new_attrs = { task_file: fixture_file_upload("/task_sets/another_valid.yml") }
          expect{task_set.update(new_attrs)}.to change{ task_set.tasks.map {|t| t.id} } 
        end
        
        it "keeps the uploaded tasks" do
          task_ids = task_set.tasks.map {|t| t.id}
          new_attrs = { task_file: fixture_file_upload("/task_sets/another_valid.yml") }
          expect{task_set.update(new_attrs)}.not_to change{ Task.where(id: task_ids).count } 
        end
      end

      context "with invalid task file" do
        it "does not change the tasks" do
          new_attrs = { task_file: fixture_file_upload("/task_sets/array_array.yml") }
          expect{task_set.update(new_attrs)}.not_to change{ task_set.tasks.map {|t| t.id} } 
        end
      end

    end
  end
  
  describe "#finished_task_results" do
    subject(:task_set) do
      create(:task_set, task_template_id: task_template.id)
    end

    subject(:task) do
      task_set.tasks.first
    end

    subject(:finished_task_results) do
      task_set.finished_task_results
    end

    context "with one task finished" do
      before do
        task.task_results.create(user_id: user.id, submitted_data: "")
      end
      it "includes one" do
        expect(finished_task_results.size).to eq(1)
        expect(finished_task_results.first.task_id).to eq(task.id)
        expect(finished_task_results.first.user_id).to eq(user.id)
      end
    end

    context "with two tasks finished" do
      context "for the same task set" do
        before do
          task.task_results.create(user_id: user.id, submitted_data: "")
          another_user = create(:user)
          task.task_results.create(user_id: another_user.id, submitted_data: "")
        end
        it "includes two" do
          expect(finished_task_results.size).to eq(2)
        end
      end
      context "for different task sets" do
        before do
          task.task_results.create(user_id: user.id, submitted_data: "")
          another_task_set = create(:task_set, task_template_id: task_template.id)
          another_task_set.tasks.first.task_results.create(user_id: user.id,
            submitted_data: "")
        end
        it "includes one" do
          expect(finished_task_results.size).to eq(1)
          expect(finished_task_results.first.task_id).to eq(task.id)
          expect(finished_task_results.first.user_id).to eq(user.id)
        end
      end
    end

  end

  describe "#destroy" do
    subject(:task_set) do
      create(:task_set, task_template_id: task_template.id)
    end

    it "destroys the task set but keeps the uploaded tasks" do
      task_ids = task_set.tasks.map {|t| t.id}
      new_attrs = { task_file: fixture_file_upload("/task_sets/another_valid.yml") }
      expect{task_set.destroy}.to change{ TaskSet.count }.by(-1)
      expect(Task.where(id: task_ids).count).to eq(task_ids.size)
    end
  end

  describe "#tasks_count" do
    let(:base) { create(:task_set, task_template_id: task_template.id) }
    let(:target_sym) { :task }
    let(:target_attributes) { attributes_for(:task, task_set_id: base.id) }

    context "with no has_many" do
      it { expect(base[target_sym.to_count]).to eq(6) }
    end

    it_behaves_like "with one has_many"
    it_behaves_like "with one has_many deleted"
    it_behaves_like "with one has_many for another" do
      let(:another) { create(:task_set, task_template_id: task_template.id) }
      let(:another_attributes) { attributes_for(:task, task_set_id: another.id) }
    end
  end

  describe "#assigns_count" do
    let(:base) { create(:task_set, task_template_id: task_template.id) }
    let(:target_sym) { :assign }
    let(:target_attributes) {
      attributes_for(:assign, task_set_id: base.id, name: user.username) }

    it_behaves_like "with no has_many"
    it_behaves_like "with one has_many"
    it_behaves_like "with one has_many deleted"
    it_behaves_like "with one has_many for another" do
      let(:another) { create(:task_set, task_template_id: task_template.id) }
      let(:another_attributes) {
        attributes_for(:assign, task_set_id: another.id, name: user.username) }
    end
  end

end
