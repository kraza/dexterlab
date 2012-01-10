class Patient < ActiveRecord::Base
  belongs_to :doctor

  validates :total_amount,  :numericality => {:greater_than_or_equal_to => 0.01}
  validates :advance_payment, :numericality => true
end
