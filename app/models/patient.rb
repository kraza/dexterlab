class Patient < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :user
  has_many :line_tests, :dependent => :destroy

  before_save :update_line_tests

  validates :initial_name, :first_name, :doctor_id, :test_execution_date, :test_delivery_date, :presence => true
  validates :total_amount,  :numericality => {:greater_than_or_equal_to => 0.01}
  validates :advance_payment, :numericality => true,  :unless  => "advance_payment.nil?"

  #scope defined here
  scope :order_by_test_date_with_range, lambda { |to_date, from_date| where("test_execution_date >= ? and test_execution_date <= ? ", to_date, from_date). order( " test_execution_date DESC")}
  scope :order_by_test_date_with_out_range,  :order =>  " test_execution_date DESC"
  
  INITIAL_NAME = [['Mr', 'mr'], ['Mrs', 'mrs'],['Miss', 'miss'], ['Master', 'master'], ['MD', 'md']]

  #this constant use as a header for csv and pdf import
  PATIENT_LIST_HEADERS = ['Test Date', 'Full Name', 'Tests',  'Total', 'Doctors Charge',  'Doctor Received paymet']
  PATIENT_LIST_HEADERS1 = ['Test Date', 'Full Name', 'Tests']
  PATIENT_LIST_HEADERS2 = [  'Total', 'Doctors Charge',  'Doctor Received paymet']
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
     initial_name+ " " +first_name.humanize + " " + last_name
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

  #calculate duse amount
  def dues
    total_amount - advance_payment
  end

  def is_recived_payment_by_doctor?
    is_doctor_receoved_payment
  end

  #Return value yes if doctor received payment from patient.
  def doctor_received_paymet
    is_recived_payment_by_doctor? ? "Yes" : "No"
  end
  
  def to_html
    temp = []

    attributes.each_pair do | attribute, value |
      temp.push( "<p>%s: %s</p>" % [ attribute, value ] )
    end

    temp.join
  end

  # Information to be populated in a particular CSV row
  # This would be modified, as per specification
  def to_ordered_array
    [self.test_execution_date, self.full_name, self.test_names, 
      self.total_amount, self.sum_of_doctor_commission, self.doctor_received_paymet]
  end # to_ordered_array
end