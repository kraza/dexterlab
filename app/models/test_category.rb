class TestCategory < ActiveRecord::Base
  belongs_to :user
  has_many :tests, :dependent => :destroy
  has_many :line_tests

  # Line test count for test
  def line_test_count
    tests.inject(0){|sum,test| (sum + test.line_tests.count)}
  end

  # display status in Active/InActive
  def status
    is_active? ? "Active" : "In Active"
  end
end
