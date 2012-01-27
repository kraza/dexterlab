class ApplicationController < ActionController::Base
  protect_from_forgery :secret => '8fc080370e56e929a2d5afca5540a0f7'

  #set date format in dd/mm/yyyy format
  def date_format(date_value)
    date_value.strftime("%d/%m/%Y")
  end
end
