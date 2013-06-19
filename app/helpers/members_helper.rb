##
# The helper for
module MembersHelper

  def action_form path, options
    form_tag path, :id => options[:form_id] do
      hidden_field_tag "ids"
      button_tag options[:button_text], :class => "submit send"
    end
  end
end