require 'spec_helper'

describe "doctors/show.html.haml" do
  before(:each) do
    @doctor = assign(:doctor, stub_model(Doctor,
      :code => "Code",
      :first_name => "First Name",
      :last_name => "Last Name",
      :designation => "Designation",
      :cell => "Cell",
      :phone => "Phone",
      :address1 => "",
      :address2 => "Address2",
      :postal => "Postal",
      :city => "City",
      :state => "State",
      :references => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Last Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Designation/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Cell/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Postal/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
