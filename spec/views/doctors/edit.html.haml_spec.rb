require 'spec_helper'

describe "doctors/edit.html.haml" do
  before(:each) do
    @doctor = assign(:doctor, stub_model(Doctor,
      :code => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :designation => "MyString",
      :cell => "MyString",
      :phone => "MyString",
      :address1 => "",
      :address2 => "MyString",
      :postal => "MyString",
      :city => "MyString",
      :state => "MyString",
      :references => ""
    ))
  end

  it "renders the edit doctor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => doctors_path(@doctor), :method => "post" do
      assert_select "input#doctor_code", :name => "doctor[code]"
      assert_select "input#doctor_first_name", :name => "doctor[first_name]"
      assert_select "input#doctor_last_name", :name => "doctor[last_name]"
      assert_select "input#doctor_designation", :name => "doctor[designation]"
      assert_select "input#doctor_cell", :name => "doctor[cell]"
      assert_select "input#doctor_phone", :name => "doctor[phone]"
      assert_select "input#doctor_address1", :name => "doctor[address1]"
      assert_select "input#doctor_address2", :name => "doctor[address2]"
      assert_select "input#doctor_postal", :name => "doctor[postal]"
      assert_select "input#doctor_city", :name => "doctor[city]"
      assert_select "input#doctor_state", :name => "doctor[state]"
      assert_select "input#doctor_references", :name => "doctor[references]"
    end
  end
end
