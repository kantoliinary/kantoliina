$(document).ready( ->
  $(document).delegate('#invoice_editor_page textarea', 'keydown', (e) ->
    keyCode = e.keyCode || e.which;

    if keyCode == 9
      e.preventDefault();
      start = $(this).get(0).selectionStart;
      end = $(this).get(0).selectionEnd;

      $(this).val($(this).val().substring(0, start) + "  " + $(this).val().substring(end))


      $(this).get(0).selectionStart =
      $(this).get(0).selectionEnd = start + 2
  )
  $(document).delegate('#reminder_editor_page textarea', 'keydown', (e) ->
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
    $("#invoice_template_form #function").val("preview")
    $("#invoice_template_form").submit()
  )
  $("#save").click((e)->
    $("#invoice_template_form #function").val("save")
    $("#invoice_template_form").submit()
  )
  $("#preview").click((e)->
    $("#reminder_template_form #function").val("preview")
    $("#reminder_template_form").submit()
  )
  $("#save").click((e)->
    $("#reminder_template_form #function").val("save")
    $("#reminder_template_form").submit()
  )
)


