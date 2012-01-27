class Patient < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :user
  has_many :line_tests, :dependent => :destroy

  before_save :update_line_tests
  
  validates :initial_name, :first_name, :doctor_id, :test_execution_date, :test_delivery_date, :presence => true
  validates :total_amount,  :numericality => {:greater_than_or_equal_to => 0.01}
  validates :advance_payment, :numericality => true,  :unless  => "advance_payment.nil?"

  # This method calculate patient position on current date.
  def position
    Patient.where("created_at >=?", Date.today ).count.to_i
  end

  # This Method generate reference number
 def reference_number
   todays_date_str = Date.today.iso8601.gsub("-","")
   "Ref/PAT/#{todays_date_str}/#{position+1}"
 end

  #Add line test with reference of patient id.
  def add_line_tests_from_cart(cart)
    cart.items.each do |item|
      li = LineTest.from_cart_item(item,self.doctor_id, self.user_id)
      line_tests << li unless self.line_tests.collect{|line_test| line_test.test_id}.include?(li.test_id)
    end
  end

  #Displat name as "First_name Last_name"
  def full_name
     first_name.humanize + " " + last_name
  end

  
  #Display all tests name for current patient
  def test_names
      line_tests.collect{|line_test| Test.find(line_test.test_id).name}.join(", ")
  end

  #Display all tests fee based in category for current patient
  def sum_of_test_fee_based_on_category
    patient_test_info ={}
    self.user.test_categories.each do |test_category|
      patient_test_info[test_category.id.to_s] = line_tests.find_all{|line_item| line_item.test_category_id == test_category.id}.inject(0){|sum,line_test| (sum + line_test.test_fee)}
    end
    patient_test_info
  end

  #Display all doctors commission for current patient
  def sum_of_doctor_commission
    line_tests.inject(0){|sum,line_test| (sum + line_test.doctors_commission)}
  end

  #Update doctor_id in line tests if changes made in patient.
  def update_line_tests
    line_tests.update_all(:doctor_id => self.doctor_id)
  end
  
end