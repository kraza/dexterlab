class TestCategory < ActiveRecord::Base
  belongs_to :user
  has_many :tests, :dependent => :destroy
  has_many :line_tests

  #Scope define here
  scope  :search_by_name,  lambda {|search_text| where(" name like '%#{search_text}%' "). order( " name")}
  
  # Line test count for test
  def line_test_count
    tests.inject(0){|sum,test| (sum + test.line_tests.count)}
  end

  # display status in Active/InActive
  def status
    is_active? ? "Active" : "In Active"
  end
end
