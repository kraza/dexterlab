require 'spec_helper'

describe "test_categories/show.html.haml" do
  before(:each) do
    @test_category = assign(:test_category, stub_model(TestCategory,
      :name => "Name",
      :description => "MyText",
      :is_active => false,
      :references => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
