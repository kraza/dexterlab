class Test < ActiveRecord::Base
  belongs_to :test_category
  belongs_to :user
  has_many :line_tests
  #attr_accessor :admin_test_category
  attr_accessor :s_no

  validates :fees, :commission_value, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :test_category_id, :code, :name, :commission_type, :presence => true
  validates :code, :uniqueness => true

  #scope is defined here
  scope  :search_by_test_name_test_code_category_name,  lambda {|search_text|  joins("join test_categories on test_categories.id = tests.test_category_id"). where("tests.name like '%#{search_text}%'  or tests.code like '%#{search_text}%' or tests.commission_type like '%#{search_text}%' or test_categories.name like '%#{search_text}%' "). order( " name DESC")}
  scope :order_by_category_name, :joins => "join test_categories on test_categories.id = tests.test_category_id", :order => "test_categories.name, tests.code"
  COMMISSION_TYPE = ["PERCENTAGE", "AMOUNT"]


  #Display commission value in based on commission type.
  def comission_value
    if self.commission_type == "PERCENTAGE"
      "#{self.commission_value.to_i}  %"
    else
      self.commission_value.to_f
    end
  end

  # Display test code and name to-gather for sexy combo box
  def name_code
    "#{self.code} - #{self.name} "
  end

  # Calculate doctor commission.
  def doctor_commission
     if self.commission_type == "PERCENTAGE"
        (self.commission_value)* (self.fees) / 100
      else
        self.commission_value
     end
  end

  # display status in Active/InActive
  def status
    is_active? ? "Active" : "In Active"
  end

  #calculate size for line test
  def line_test_count
    line_tests.count
  end
end