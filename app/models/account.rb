class Account < ActiveRecord::Base

  belongs_to :user
  belongs_to :doctor

  #Calculate update dues amount after payment
  def dues
    dues_amount - paid_amount
  end
  
end
