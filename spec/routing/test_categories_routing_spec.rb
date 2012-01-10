require "spec_helper"

describe TestCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/test_categories").should route_to("test_categories#index")
    end

    it "routes to #new" do
      get("/test_categories/new").should route_to("test_categories#new")
    end

    it "routes to #show" do
      get("/test_categories/1").should route_to("test_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/test_categories/1/edit").should route_to("test_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/test_categories").should route_to("test_categories#create")
    end

    it "routes to #update" do
      put("/test_categories/1").should route_to("test_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/test_categories/1").should route_to("test_categories#destroy", :id => "1")
    end

  end
end
