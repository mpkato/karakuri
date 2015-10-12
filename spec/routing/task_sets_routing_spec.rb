require "rails_helper"

RSpec.describe TaskSetsController, type: :routing do
  pending "add some examples to (or delete) #{__FILE__}"
<<EOS
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/task_sets").to route_to("task_sets#index")
    end

    it "routes to #new" do
      expect(:get => "/task_sets/new").to route_to("task_sets#new")
    end

    it "routes to #show" do
      expect(:get => "/task_sets/1").to route_to("task_sets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/task_sets/1/edit").to route_to("task_sets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/task_sets").to route_to("task_sets#create")
    end

    it "routes to #update" do
      expect(:put => "/task_sets/1").to route_to("task_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/task_sets/1").to route_to("task_sets#destroy", :id => "1")
    end

  end
EOS
end
