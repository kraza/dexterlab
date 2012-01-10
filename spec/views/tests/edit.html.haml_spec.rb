require 'spec_helper'

describe "tests/edit.html.haml" do
  before(:each) do
    @test = assign(:test, stub_model(Test,
      :code => "MyString",
      :name => "MyString",
      :fees => "9.99",
      :commission_type => "MyString",
      :commission_value => "9.99",
      :description => "MyText",
      :is_active => false,
      :references => "",
      :references => ""
    ))
  end

  it "renders the edit test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tests_path(@test), :method => "post" do
      assert_select "input#test_code", :name => "test[code]"
      assert_select "input#test_name", :name => "test[name]"
      assert_select "input#test_fees", :name => "test[fees]"
      assert_select "input#test_commission_type", :name => "test[commission_type]"
      assert_select "input#test_commission_value", :name => "test[commission_value]"
      assert_select "textarea#test_description", :name => "test[description]"
      assert_select "input#test_is_active", :name => "test[is_active]"
      assert_select "input#test_references", :name => "test[references]"
      assert_select "input#test_references", :name => "test[references]"
    end
  end
end
