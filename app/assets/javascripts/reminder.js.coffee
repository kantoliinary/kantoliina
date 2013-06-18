$(document).ready ->
  console.log($("#reminder_member_page"))
  $("#reminder_member_page").find("#preview_form").submit( ->
    $(this).find(".top_message").val($("#reminder_member_page").find("#reminder_invoice_form").find(".top_message").val())
    $(this).find(".bottom_message").val($("#reminder_member_page").find("#reminder_invoice_form").find(".bottom_message").val())
  )