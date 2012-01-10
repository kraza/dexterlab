require 'spec_helper'

describe "patients/new.html.haml" do
  before(:each) do
    assign(:patient, stub_model(Patient,
      :refrence_no => "MyString",
      :initial_name => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :total_amount => "9.99",
      :advance_payment => "9.99",
      :is_doctor_receoved_payment => false,
      :references => ""
    ).as_new_record)
  end

  it "renders new patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => patients_path, :method => "post" do
      assert_select "input#patient_refrence_no", :name => "patient[refrence_no]"
      assert_select "input#patient_initial_name", :name => "patient[initial_name]"
      assert_select "input#patient_first_name", :name => "patient[first_name]"
      assert_select "input#patient_last_name", :name => "patient[last_name]"
      assert_select "input#patient_total_amount", :name => "patient[total_amount]"
      assert_select "input#patient_advance_payment", :name => "patient[advance_payment]"
      assert_select "input#patient_is_doctor_receoved_payment", :name => "patient[is_doctor_receoved_payment]"
      assert_select "input#patient_references", :name => "patient[references]"
    end
  end
end
