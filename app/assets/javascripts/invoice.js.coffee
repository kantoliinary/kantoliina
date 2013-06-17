$(document).ready ->
  $("#invoice_member_page").find("#preview_form").submit( ->
    $(this).find(".top_message").val($("#invoice_member_page").find("#invoice_form").find(".top_message").val())
    $(this).find(".bottom_message").val($("#invoice_member_page").find("#invoice_form").find(".bottom_message").val())
  )

