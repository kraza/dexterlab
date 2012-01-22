class Patient < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :user
  has_many :line_tests

  validates :initial_name, :first_name, :doctor_id, :test_execution_date, :test_delivery_date, :presence => true
  validates :total_amount,  :numericality => {:greater_than_or_equal_to => 0.01}
  validates :advance_payment, :numericality => true

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
end
