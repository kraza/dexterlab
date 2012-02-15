class TestCategory < ActiveRecord::Base
  belongs_to :user
  has_many :tests, :dependent => :destroy
  has_many :line_tests

  after_save :deactivate_all_tests, :unless => "is_active"
  validates  :name,  :presence => true
  validates :name, :uniqueness => {:scope => :user_id}

  #Scope define here
  scope  :search_by_name,  lambda {|search_text| where(" name like '%#{search_text}%' "). order( " name")}
  scope :active, where(:is_active => true).order(:name)
  
  # Deactivate all test for current test category if test category deactivated.
  def deactivate_all_tests
    tests.update_all(:is_active => false)
  end
  
  # Line test count for test
  def line_test_count
    tests.inject(0){|sum,test| (sum + test.line_tests.count)}
  end

  # display status in Active/InActive
  def status
    is_active? ? "Active" : "In Active"
  end
end
