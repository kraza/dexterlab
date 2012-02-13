module TestsHelper

  #Display commission value in based on commission type.
  def comission_format(obj)
    if obj.commission_type == "PERCENTAGE"
      "#{obj.commission_value.to_i}  %"
    else
      number_to_currency(obj.commission_value,:unit => "")
    end
  end
  
end
