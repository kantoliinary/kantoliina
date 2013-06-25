index_page = ""
invoice = ""
mailer = ""
reminder = ""
$(document).ready ->
  index_page = "#index_member_page"
  invoice = $("#invoice_member_page")
  mailer = $("#mailer_member_page")
  reminder = $("#reminder_member_page")
  $(index_page).find(".send").click (e) ->
    e.preventDefault()
    if $(this).hasClass("confirm") && !confirm("Oletko varma?")
      return false
    checkboxs = $(index_page).find("#members").find("table").find("td").find(":checkbox")
    ids = []
    $(checkboxs).each (index, value) ->
      checkbox = $(value)
      if !!checkbox.is(":checked") && checkbox.attr("name") != "check_all"
        ids.push checkbox.val()
    form = $(this).parent("form")
    if ids.length != 0
      $("<input/>",{
        type: "hidden",
        name: "ids"
        value: JSON.stringify({
          ids: ids
        })
      }).appendTo(form)
      form.submit()
    else
      alert("Valitse ensin jäseniä")

  $(index_page).find("#members").find("#check_all").click( (e) ->
    un_select_all_mmembers(e)
  )

  $(".delete_row_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    $($(this).parent("td").parent("tr").parent("tbody").parent("table").data("form")).find(".member_" + id).remove()
    $(this).parent("td").parent("tr").remove()

  mailer.find("#mailer_form").find(".send").click (e) ->
    e.preventDefault
    sender =  $(mailer.find("#mailer_form").find("#senderarea").find("#sender")).val()

    if sender.match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
      $(mailer.find("#mailer_form")).submit()

    else
      alert("Antamasi sähköpostiosoite on virheellinen")
      return false

  reminder.find("#members").find(".delete_button").click (e) ->
    e.preventDefault
    id = $(this).data("id")
    parent = $(this).parent("td").parent("tr").remove()
    reminder.find("#reminder_form").find(".member_" + id).remove()

  multiselect().init({
      elements: [index_page + " .column_menu"],
      initItemCallback: (checkbox) ->
        setTableColumns(checkbox)
      ,itemCallback: (checkbox) ->
        showHideColumn(checkbox)
    })

  multiselect().init({
      elements: [index_page + " .membergroup_menu", index_page + " .paymentstatus_menu", index_page + " .support_menu", index_page + " .lender_menu", index_page + " .municipality_menu", index_page + " .active_menu"]
      callback: (element) ->
        do_search()
  })

  $("#search_button").click( (e) ->
    do_search()
  )
  sorter.init({
    table: "#members_table",
    except: ["checkboxs"]
  })

  $("#random_button").click( (e) ->
    do_random()
  )
  $(index_page).find("#searchfield").keypress((e) ->
    enterSearch(e)
  )
  do_search()
  setTimeout(hideNoticeAndError, 10000)
do_search = ->
  search({
    selectgroups: [[".municipality_menu", "municipalitys"], [".membergroup_menu", "membergroups"], [".paymentstatus_menu", "paymentstatus"], [".support_menu", "support"], [".lender_menu", "lender"], [".active_menu", "active"]],
    outputtable: "#members_table",
    column_menu: ".column_menu",
    outputlengthfield: index_page + " #amount_of_results #amount",
    callback: ->
      sorter.sort(undefined, true)
      changeRemoveActiveButton()
  })

changeRemoveActiveButton = ->
  button = $(index_page).find("#delete_active_form").find("button")
  if $(index_page).find(".active_menu").find("input").is(":checked")
    button.text("Aktivoi")
  else
     button.text("Poista")

setTableColumns = (checkbox)->
  th = $(index_page).find("#members").find("table").find("."+$(checkbox).attr("name"))
  if $(checkbox).is(":checked")
    th.removeClass("hidden")
  else
    th.addClass("hidden")

showHideColumn = (checkbox) ->
  $(index_page).find("#members").find("table").find("." + $(checkbox).attr("name")).each (index, item) ->
    if $(item).hasClass("hidden")
      $(item).removeClass("hidden")
    else
      $(item).addClass("hidden")

enterSearch = (e) ->
  if e.which == 13
    do_search()
hideNoticeAndError = ->
  $("#notice").hide().text("")
  $(index_page).find(".error").hide().text("")