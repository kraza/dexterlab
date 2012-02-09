module ApplicationHelper

  #set date format in dd/mm/yyyy format
  def date_format(date_value)
    date_value.strftime("%d/%m/%Y")
  end

  # bulid button based on lite test values
  def destroy_active_deactive_button(model_obj)
    if model_obj.line_test_count > 0
      if model_obj.is_active?
        link_to 'Deactivate',  model_obj, :confirm => 'Are you sure to Deactive it?',  :method => :put, :remote => true, :class => 'btn warning-mix btn-width textAlignCenter'
      else
        link_to 'Activate',  model_obj, :confirm => 'Are you sure to Activate it?',  :method => :put, :remote => true,  :class => 'btn success btn-width textAlignCenter'
      end
   else
      link_to 'Destroy', model_obj, :confirm => 'Are you sure to Destroy it?',
          :method => :delete, :class => 'btn  danger btn-width textAlignCenter'
    end
  end

end
