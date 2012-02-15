module ApplicationHelper

  #set date format in dd/mm/yyyy format
  def date_format(date_value)
    date_value.strftime("%d/%m/%Y")
  end

  # bulid button based on lite test values
  def destroy_active_deactive_button(model_obj)
    tests_category = true
    if model_obj.class.name == "TestCategory"
      confirm_msg_destroy = "Are you sure you want to delete '#{model_obj.name.upcase}'? It will delete all tests under this category"
      confirm_msg_deactivate = "Are you sure you want to deactivate '#{model_obj.name.upcase}'? It will deactivate all tests under this category"
    elsif model_obj.class.name == "Test"
      confirm_msg_destroy  = "Are you sure you want to delete '#{model_obj.name.upcase}'?"
      confirm_msg_deactivate = "Are you sure you want to deactivate '#{model_obj.name.upcase}'?"
      tests_category = model_obj.test_category.is_active?
    else
      confirm_msg_destroy  = "Are you sure you want to delete '#{model_obj.name.titleize}'?"
      confirm_msg_deactivate  = "Are you sure you want to deactivate '#{model_obj.name.titleize}'?"
    end
      if model_obj.is_active?
        result_button = link_to 'Deactivate',  model_obj, :confirm => confirm_msg_deactivate,  :method => :put, :remote => true, :class => 'btn warning-mix btn-width textAlignCenter'
      else
        result_button = link_to_if(tests_category == true,  'Activate',  model_obj, :confirm => "Are you sure you want to activate '#{model_obj.name.titleize}'?",  :method => :put, :remote => true,  :class => 'btn success btn-width textAlignCenter') do
          content_tag(:span, "Activate",  :class => 'btn success disabled')
        end
      end
      result_button += " "
      result_button += link_to_unless(model_obj.line_test_count > 0, 'Delete', model_obj, :confirm => confirm_msg_destroy ,
        :method => :delete, :class => 'btn  danger btn-width textAlignCenter') do
          content_tag(:span, "Delete",  :class => 'btn danger disabled btn-width textAlignCenter')
        end
      result_button.html_safe
  end
  
  # code field editable for new form and
  def code_field(model_obj)
    if model_obj.object.code.blank?
      return_value = model_obj.text_field :code
    else
      return_value = model_obj.text_field :code, :disabled => true
    end
    return_value.html_safe
  end
  
end
