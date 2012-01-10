require 'spec_helper'

describe "doctors/index.html.haml" do
  before(:each) do
    assign(:doctors, [
      stub_model(Doctor,
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
      ),
      stub_model(Doctor,
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
      )
    ])
  end

  it "renders a list of doctors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Designation".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Cell".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address2".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Postal".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
