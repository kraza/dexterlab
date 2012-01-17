class Patient < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :user

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


end
