require 'spec_helper'

describe ReportsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'patient'" do
    it "should be successful" do
      get 'patient'
      response.should be_success
    end
  end

  describe "GET 'testvspatient'" do
    it "should be successful" do
      get 'testvspatient'
      response.should be_success
    end
  end

  describe "GET 'doctorvstest'" do
    it "should be successful" do
      get 'doctorvstest'
      response.should be_success
    end
  end

  describe "GET 'doctorvspatient'" do
    it "should be successful" do
      get 'doctorvspatient'
      response.should be_success
    end
  end

end
