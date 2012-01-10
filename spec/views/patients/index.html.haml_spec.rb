require 'spec_helper'

describe "patients/index.html.haml" do
  before(:each) do
    assign(:patients, [
      stub_model(Patient,
        :refrence_no => "Refrence No",
        :initial_name => "Initial Name",
        :first_name => "First Name",
        :last_name => "Last Name",
        :total_amount => "9.99",
        :advance_payment => "9.99",
        :is_doctor_receoved_payment => false,
        :references => ""
      ),
      stub_model(Patient,
        :refrence_no => "Refrence No",
        :initial_name => "Initial Name",
        :first_name => "First Name",
        :last_name => "Last Name",
        :total_amount => "9.99",
        :advance_payment => "9.99",
        :is_doctor_receoved_payment => false,
        :references => ""
      )
    ])
  end

  it "renders a list of patients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Refrence No".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Initial Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
