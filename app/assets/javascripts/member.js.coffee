$(document).ready ->
  index = $ "#index_member_page"
  invoice = $ "#invoice_member_page"
  index.find("#send_invoice").click (e) ->
    e.preventDefault()
    checkboxs = $("#index_member_page #members").find ":checkbox"
    ids = []
    $(checkboxs).each (index, value) ->
      checkbox = $ value
      if !!checkbox.attr("checked") && checkbox.attr("name") != "check_all"
        ids.push checkbox.val()

    form = $("#index_member_page #invoice_form")
    form.children("#ids").val(JSON.stringify({
      ids: ids
    }))
    if ids.length != 0
      form.submit()
  index.find("#check_all").click ->
    checkboxs = index.children("#members").find ":checkbox"
    check_state = !!$(this).attr "checked"
    $(checkboxs).each (index, value) ->
      $(value).attr "checked", check_state
  invoice.find("#members").find(".delete_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    parent = $(this).parent("td").parent("tr").remove()
    invoice.find("#invoice_form").find(".member_"+id).remove()
