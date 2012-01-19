class Test < ActiveRecord::Base
  belongs_to :test_category
  belongs_to :user
  #attr_accessor :admin_test_category
  attr_accessor :s_no

  validates :fees, :commission_value, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :test_category_id, :code, :name, :commission_type, :presence => true
  validates :code, :uniqueness => true

COMMISSION_TYPE = ["PERCENTAGE", "AMOUNT"]


  #Display commission value in based on commission type.
  def comission_value
    if self.commission_type == "percentage"
      "#{self.commission_value.to_i}  %"
    else
      self.commission_value
    end
  end

  # Display test code and name to-gather for sexy combo box
  def name_code
    "#{self.code} - #{self.name} "
  end

# Calculate doctor commission.
def doctor_commission
   if self.commission_type == "percentage"
      (self.commission_value.to_i) / 100
    else
      self.commission_value
   end
end

end
