require 'rails_helper'

RSpec.describe "task_sets/new", type: :view do
  pending "add some examples to (or delete) #{__FILE__}"
<<EOS
  before(:each) do
    assign(:task_set, TaskSet.new(
      :label => "MyString",
      :task_template => nil
    ))
  end

  it "renders new task_set form" do
    render

    assert_select "form[action=?][method=?]", task_sets_path, "post" do

      assert_select "input#task_set_label[name=?]", "task_set[label]"

      assert_select "input#task_set_task_template_id[name=?]", "task_set[task_template_id]"
    end
  end
EOS
end
