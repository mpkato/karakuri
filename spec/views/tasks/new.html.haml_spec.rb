require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :label => "MyString",
      :html_form => "MyText",
      :user => nil
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_label[name=?]", "task[label]"

      assert_select "textarea#task_html_form[name=?]", "task[html_form]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"
    end
  end
end
