require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :label => "MyString",
      :html_form => "MyText",
      :user => nil
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input#task_label[name=?]", "task[label]"

      assert_select "textarea#task_html_form[name=?]", "task[html_form]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"
    end
  end
end
