##
# The helper for
module MembersHelper

  def action_form path, options
    form_tag path, :id => options[:form_id] do
      button_tag options[:button_text], :class => "submit send" + (options[:confirm] ? " confirm" : "")
    end
  end
end