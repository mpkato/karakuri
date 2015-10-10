require 'rails_helper'

RSpec.describe "task_sets/edit", type: :view do
  before(:each) do
    @task_set = assign(:task_set, TaskSet.create!(
      :label => "MyString",
      :task_template => nil
    ))
  end

  it "renders the edit task_set form" do
    render

    assert_select "form[action=?][method=?]", task_set_path(@task_set), "post" do

      assert_select "input#task_set_label[name=?]", "task_set[label]"

      assert_select "input#task_set_task_template_id[name=?]", "task_set[task_template_id]"
    end
  end
end
