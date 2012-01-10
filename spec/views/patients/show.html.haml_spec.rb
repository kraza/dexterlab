require 'spec_helper'

describe "patients/show.html.haml" do
  before(:each) do
    @patient = assign(:patient, stub_model(Patient,
      :refrence_no => "Refrence No",
      :initial_name => "Initial Name",
      :first_name => "First Name",
      :last_name => "Last Name",
      :total_amount => "9.99",
      :advance_payment => "9.99",
      :is_doctor_receoved_payment => false,
      :references => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Refrence No/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Initial Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Last Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
