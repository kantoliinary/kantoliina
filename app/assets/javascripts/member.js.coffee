$(document).ready ->
  index = $("#index_member_page")
  invoice = $("#invoice_member_page")
  index.find(".send").click (e) ->
    e.preventDefault()
    if $(this).hasClass("confirm") && !confirm("Oletko varma?")
      return false
    checkboxs = index.find("#members").find(":checkbox")
    ids = []
    $(checkboxs).each (index, value) ->
      checkbox = $(value)
      if !!checkbox.attr("checked") && checkbox.attr("name") != "check_all"
        ids.push checkbox.val()

    form = $(this).parent("form")
    form.children("#ids").val(JSON.stringify({
      ids: ids
    }))
    if ids.length != 0
      form.submit()
  index.find("#check_all").click ->
    checkboxs = index.children("#centered").children("#members").find(":checkbox")
    check_state = !!$(this).attr "checked"
    $(checkboxs).each (index, value) ->
      $(value).attr "checked", check_state

  index.find("#members").find("table").find(":checkbox").click (e) ->
    checkboxs = index.find("#members").find(":checkbox")

    $("#bottom_forms").show()
    checked = false
    $(checkboxs).each (index, value) ->
      checkbox = $(value)
      if checkbox.attr("checked")
        checked = true
        return false
    if !checked
      $("#bottom_forms").hide()

  invoice.find("#members").find(".delete_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    parent = $(this).parent("td").parent("tr").remove()
    invoice.find("#invoice_form").find(".member_"+id).remove()
  $(".column_menu").find(".header").click (e) ->
    $(this).parent().find(".choices").toggle()
  $(".column_menu").find(".choices").find("input").click (e) ->
    name = $(this).attr("name")
    $("#members").find("."+name).each (index, element) ->
      if $(element).hasClass("hidden")
        $(element).removeClass("hidden")
      else
        $(element).addClass("hidden")