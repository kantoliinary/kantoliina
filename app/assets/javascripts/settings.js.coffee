$(document).ready( ->
  $(document).delegate('#settings_page textarea', 'keydown', (e) ->
    keyCode = e.keyCode || e.which;

    if keyCode == 9
      e.preventDefault();
      start = $(this).get(0).selectionStart;
      end = $(this).get(0).selectionEnd;

      $(this).val($(this).val().substring(0, start) + "  " + $(this).val().substring(end))


      $(this).get(0).selectionStart =
      $(this).get(0).selectionEnd = start + 2
  )
  $("#preview").click((e)->
    $("#invoice_template_form").val("preview")
    $("#invoice_template_form").submit()
  )
)

