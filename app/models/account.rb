class Account < ActiveRecord::Base

  belongs_to :user
  belongs_to :doctor

   validates :paid_amount, :numericality => {:greater_than_or_equal_to => 0.01}
  #Calculate update dues amount after payment
  def dues
    dues_amount - paid_amount
  end
  
end
