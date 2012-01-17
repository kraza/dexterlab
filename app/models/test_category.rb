class TestCategory < ActiveRecord::Base
  belongs_to :user
  has_many :tests

end
