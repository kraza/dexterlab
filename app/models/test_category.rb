class TestCategory < ActiveRecord::Base
  belongs_to :user
  has_many :tests
  has_many :line_tests

end
