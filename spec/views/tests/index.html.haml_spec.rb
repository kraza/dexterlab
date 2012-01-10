require 'spec_helper'

describe "tests/index.html.haml" do
  before(:each) do
    assign(:tests, [
      stub_model(Test,
        :code => "Code",
        :name => "Name",
        :fees => "9.99",
        :commission_type => "Commission Type",
        :commission_value => "9.99",
        :description => "MyText",
        :is_active => false,
        :references => "",
        :references => ""
      ),
      stub_model(Test,
        :code => "Code",
        :name => "Name",
        :fees => "9.99",
        :commission_type => "Commission Type",
        :commission_value => "9.99",
        :description => "MyText",
        :is_active => false,
        :references => "",
        :references => ""
      )
    ])
  end

  it "renders a list of tests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Commission Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
