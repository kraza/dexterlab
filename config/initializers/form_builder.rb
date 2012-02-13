# Bootstrap-compatible way to present error messages in a Rails 3 form.
# This allows us to use f.error_messages without including the dynamic_form plugin.
# Plus, it looks nicer...
# -jf
class ActionView::Helpers::FormBuilder
  # get access to pluralize method...
  include ActionView::Helpers::TextHelper

  def error_messages
    return unless object.respond_to?(:errors) && object.errors.any?

    # collect errors
    errors = ""
    errors << object.errors.full_messages.map { |message| @template.content_tag(:li, message) }.join("\n")

    # build error message
    errors_list = ""

    errors_list << @template.content_tag(
      :p,
      @template.content_tag(
        :strong,
        "#{ pluralize( object.errors.count, 'error', 'errors' ) } occurred while processing your request:"
      )
    )

    errors_list << @template.content_tag(:ul, errors.html_safe, :class => "")

    # wrap error message in div
    @template.content_tag(:div, errors_list.html_safe, :class => "alert-message block-message error")
  end
end

