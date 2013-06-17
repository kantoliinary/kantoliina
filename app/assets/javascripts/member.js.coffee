$(document).ready ->
  index = $("#index_member_page")
  invoice = $("#invoice_member_page")
  mailer = $("#mailer_member_page")
  reminder = $("#reminder_member_page")
  index.find(".send").click (e) ->
    e.preventDefault()
    if $(this).hasClass("confirm") && !confirm("Oletko varma?")
      return false
    checkboxs = index.find("#members").find("table").find("td").find(":checkbox")
    ids = []
    $(checkboxs).each (index, value) ->
      checkbox = $(value)
      if !!checkbox.is(":checked") && checkbox.attr("name") != "check_all"
        ids.push checkbox.val()
    form = $(this).parent("form")
    form.children("#ids").val(JSON.stringify({
      ids: ids
    }))
    if ids.length != 0
      form.submit()

  index.find("#members").find("#check_all").click( (e) ->
    un_select_all_mmembers(e)
  )

  index.find("#members").find("table").find("td").find(".member_select_checkbox").click( (e) ->
    member_bottom_form_show(e)
  )

  invoice.find("#members").find(".delete_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    parent = $(this).parent("td").parent("tr").remove()
    invoice.find("#invoice_form").find(".member_" + id).remove()

  mailer.find("#members").find(".delete_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    parent = $(this).parent("td").parent("tr").remove()
    mailer.find("#mailer_form").find(".member_" + id).remove()

  reminder.find("#members").find(".delete_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    parent = $(this).parent("td").parent("tr").remove()
    reminder.find("#reminder_form").find(".member_" + id).remove()

  multiselect({
      contextmenu: true,
      elements: ["#index_member_page .column_menu"],
      callback: (checkbox) ->
        th = index.find("#members").find("table").find("."+$(checkbox).attr("name"))
        if $(checkbox).is(":checked")
          th.removeClass("hidden")
        else
          th.addClass("hidden")
    }, (element) ->
      $("#members").find("table").find("." + $(element).attr("name")).each (index, item) ->
        if $(item).hasClass("hidden")
          $(item).removeClass("hidden")
        else
          $(item).addClass("hidden")
  , null)

  multiselect({
      contextmenu: true,
      elements: ["#index_member_page .membergroup_menu", "#index_member_page .paymentstatus_menu", "#index_member_page .support_menu", "#index_member_page .lender_menu", "#index_member_page .municipality_menu", "#index_member_page .deleted_menu"]
    }, null, (element) ->
      do_search()
  )

  $("#search_button").click( (e) ->
    do_search()
  )
  sorter.init({
    table: "#members_table",
  })

  do_search()
do_search = ->
  search({
    selectgroups: [[".municipality_menu", "municipalitys"], [".membergroup_menu", "membergroups"], [".paymentstatus_menu", "paymentstatus"], [".support_menu", "support"], [".lender_menu", "lender"], [".deleted_menu", "deleted"]],
    outputtable: "#members_table",
    column_menu: ".column_menu",
    outputlengthfield: "#index_member_page #amount_of_results #amount",
    callback: ->
      sorter.sort(undefined, true)
  })


