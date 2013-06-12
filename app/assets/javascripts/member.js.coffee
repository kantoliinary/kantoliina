$(document).ready ->
  index = $("#index_member_page")
  invoice = $("#invoice_member_page")
  mailer = $("#mailer_member_page")
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
    invoice.find("#mailer_form").find(".member_" + id).remove()

  multiselect({elements: ["#index_member_page .column_menu"]}, (element) ->
    $("#members").find("table").find("." + $(element).attr("name")).each (index, item) ->
      if $(item).hasClass("hidden")
        $(item).removeClass("hidden")
      else
        $(item).addClass("hidden")
  , null)

  multiselect({
      contextmenu: true,
      elements: ["#index_member_page .membergroup_menu", "#index_member_page .paymentstatus_menu", "#index_member_page .support_menu", "#index_member_page .lender_menu" ]
    }, null, (element) ->
      search({
        selectgroups: [[".membergroup_menu", "membergroups"], [".paymentstatus_menu", "paymentstatus"], [".support_menu", "support"], [".lender_menu", "lender"]],
        outputtable: "#members_table",
        column_menu: ".column_menu"
      })
  )
  search({
    selectgroups: [[".membergroup_menu", "membergroups"], [".paymentstatus_menu", "paymentstatus"], [".support_menu", "support"], [".lender_menu", "lender"]],
    outputtable: "#members_table",
    column_menu: ".column_menu"
  })
