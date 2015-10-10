require 'rails_helper'

RSpec.describe "task_sets/index", type: :view do
  before(:each) do
    assign(:task_sets, [
      TaskSet.create!(
        :label => "Label",
        :task_template => nil
      ),
      TaskSet.create!(
        :label => "Label",
        :task_template => nil
      )
    ])
  end

  it "renders a list of task_sets" do
    render
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
