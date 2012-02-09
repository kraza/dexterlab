module DoctorsHelper

  #This method append Advance word in total dues section in listing grid
  # If Doctor has already received payment in advance.
  def display_amount_based_on_payment_status(amount)
    if amount > 0
      amount = amount
    else
      amount = "#{- amount }(Advance)"
    end
    number_to_currency(amount, :unit => "Rs: ")
  end
  
end
