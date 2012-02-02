class Doctor < ActiveRecord::Base
  belongs_to :user
  has_many :patients
  has_many :line_tests
  has_many :accounts

  before_destroy :check_line_tests
  after_save :set_doc_code, :if => "code.empty?"
  
  validates  :first_name, :designation, :cell, :presence => true
  validates :email,   :presence => true,  :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :code, :uniqueness => true, :unless  => "code.empty?"


  #scope defined here
  scope :order_by_code_asc, :order => "code"

  def name
    "#{self.first_name} #{last_name}"
  end


  def set_doc_code
    self.code = self.first_name[0..2].upcase+"-"+Date.today.year.to_s+"-"+self.id.to_s
    self.send("code=", self.code)
    self.save #if code.empty?
  end

  #check linetest before destroy
  def check_line_tests
    false if self.line_tests.size > 0
  end

  #calculate total commission
  def total_commission
    line_tests.inject(0){|sum,line_test| (sum + line_test.doctors_commission)}
  end

  # Total Amount paid to doctor
  def total_paid_commission
    accounts.inject(0){|sum, account| (sum + account.paid_amount )}
  end
  
  #Calculate Total dues commission
  def total_dues_commission
    total_commission  -  total_paid_commission
  end

  #Calculate total lab earn from current doctor object
  def lab_earn
    line_tests.inject(0){|sum,line_test| (sum + line_test.test_fee)}
  end

  #Calculate patient count for doctor
  def patient_count
    patients.count
  end

end