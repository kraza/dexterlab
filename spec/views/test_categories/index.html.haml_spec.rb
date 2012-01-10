require 'spec_helper'

describe "test_categories/index.html.haml" do
  before(:each) do
    assign(:test_categories, [
      stub_model(TestCategory,
        :name => "Name",
        :description => "MyText",
        :is_active => false,
        :references => ""
      ),
      stub_model(TestCategory,
        :name => "Name",
        :description => "MyText",
        :is_active => false,
        :references => ""
      )
    ])
  end

  it "renders a list of test_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
