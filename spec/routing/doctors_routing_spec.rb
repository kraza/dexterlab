require "spec_helper"

describe DoctorsController do
  describe "routing" do

    it "routes to #index" do
      get("/doctors").should route_to("doctors#index")
    end

    it "routes to #new" do
      get("/doctors/new").should route_to("doctors#new")
    end

    it "routes to #show" do
      get("/doctors/1").should route_to("doctors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/doctors/1/edit").should route_to("doctors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/doctors").should route_to("doctors#create")
    end

    it "routes to #update" do
      put("/doctors/1").should route_to("doctors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/doctors/1").should route_to("doctors#destroy", :id => "1")
    end

  end
end
