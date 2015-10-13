require 'rails_helper'

RSpec.describe TaskTemplate, type: :model do
  let(:user) {
    create(:user)
  }

  describe "#validate" do
    subject(:task_template) {
      TaskTemplate.new(attributes)
    }

    context "with valid attributes" do
      let(:attributes) {
        attributes_for(:task_template, user_id: user.id)
      }
      it { expect(task_template).to be_valid }
    end

    context "with empty label" do
      let(:attributes) { 
        attributes_for(:task_template, user_id: user.id,
          label: "")
      }
      it "is invalid due to label" do
        expect(task_template).to be_invalid
        expect(task_template.errors[:label]).to be_present
      end
    end

    context "with empty title_template" do
      let(:attributes) { 
        attributes_for(:task_template, user_id: user.id,
          title_template: "")
      }
      it "is invalid due to title_template" do
        expect(task_template).to be_invalid
        expect(task_template.errors[:title_template]).to be_present
      end
    end

    context "with invalid title_template" do
      let(:attributes) { 
        attributes_for(:task_template, user_id: user.id,
          title_template: "{{")
      }
      it "is invalid due to title_template" do
        expect(task_template).to be_invalid
        expect(task_template.errors[:title_template]).to be_present
      end
    end

    context "with empty user_id" do
      let(:attributes) { 
        attributes_for(:task_template)
      }
      it "is invalid due to user_id" do
        expect(task_template).to be_invalid
        expect(task_template.errors[:user_id]).to be_present
      end
    end

    context "with empty form_template" do
      let(:attributes) { 
        attributes_for(:task_template, user_id: user.id,
          form_template: "")
      }
      it "is still valid" do
        expect(task_template).to be_valid
      end
    end

    context "with invalid form_template" do
      let(:attributes) { 
        attributes_for(:task_template, user_id: user.id,
          form_template: "{{")
      }
      it "is invalid due to form_template" do
        expect(task_template).to be_invalid
        expect(task_template.errors[:form_template]).to be_present
      end
    end
  end

  describe "#preview" do
    subject(:task_template) {
      TaskTemplate.new(attributes)
    }

    context "with valid form_template" do
      let(:attributes) {
        attributes_for(:task_template, user_id: user.id,
          form_template: "a {{ b }} c", preview_yaml_data: "{b: 'd'}")
      }
      it "renders html" do
        expect(task_template.preview).to eq("a d c")
      end
    end

    context "with invalid form_template" do
      let(:attributes) {
        attributes_for(:task_template, user_id: user.id,
          form_template: "{{", preview_yaml_data: "{b: 'd'}")
      }
      it "is invalid due to form_template" do
        expect(task_template.preview).to start_with("Syntax error")
      end
    end
  end

  describe "#destroy" do
    subject(:task_template) do
      create(:task_template, user_id: user.id)
    end

    it "also destroys its task_sets" do
      task_template.task_sets.create(attributes_for(:task_set))
      task_set_ids = task_template.task_sets.map {|t| t.id}
      expect{task_template.destroy}.to change{ TaskTemplate.count }.by(-1).and\
        change{TaskSet.where(id: task_set_ids).count}.by(-1)
    end
  end

  describe "#task_sets_count" do
    let(:base) { create(:task_template, user_id: user.id) }
    let(:target_sym) { :task_set }
    let(:target_attributes) { attributes_for(:task_set, task_template_id: base.id) }

    it_behaves_like "with no has_many"

    it_behaves_like "with one has_many"

    it_behaves_like "with one has_many deleted"

    it_behaves_like "with one has_many for another" do
      let(:another) { create(:task_template, user_id: user.id) }
      let(:another_attributes) { attributes_for(:task_set, task_template_id: another.id) }
    end
  end

end
