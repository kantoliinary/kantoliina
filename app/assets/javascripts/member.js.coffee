#Global variables
index_page = ""
invoice = ""
mailer = ""
reminder = ""
multiselect_search = {}
searcher = {}
#Subroutines which are run when the page has been loaded completely
$(document).ready ->
  index_page = "#index_member_page"
  invoice = $("#invoice_member_page")
  mailer = $("#mailer_member_page")
  reminder = $("#reminder_member_page")
  $(index_page).find(".send").click (e) ->
    sendForm(e)

  $(index_page).find("#members").find("#check_all").click( (e) ->
    un_select_all_mmembers(e)
  )

  $(".delete_row_button").click (e) ->
    deleteRow(e)

  mailer.find("#mailer_form").find(".send").click (e) ->
    checkEmail(e)

  reminder.find("#members").find(".delete_button").click (e) ->
    deleteRow2(e)

  multiselect().init({
      elements: [index_page + " .column_menu"],
      initItemCallback: (checkbox) ->
        setTableColumns(checkbox)
      ,itemCallback: (checkbox) ->
        showHideColumn(checkbox)
    })

  multiselect_search = multiselect().init({
      elements: [index_page + " .membergroup_menu", index_page + " .paymentstatus_menu", index_page +
      " .support_menu", index_page + " .lender_menu", index_page + " .municipality_menu", index_page + " .active_menu"]
      callback: (element) ->
        do_search()
  })
  $("#search_button").click( (e) ->
    do_search()
  )
  $("#clear_search").click( (e) ->
    $("#searchfield").val("")
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
  searcher = search()
  searcher.init({
    selectgroups: [[".municipality_menu", "municipalitys"], [".membergroup_menu", "membergroups"],
                   [".paymentstatus_menu", "paymentstatus"], [".support_menu", "support"], [".lender_menu", "lender"], [".active_menu", "active"]],
    outputtable: "#members_table",
    column_menu: ".column_menu",
    outputlengthfield: index_page + " #amount_of_results #amount",
    callback: ->
      sorter.sort(undefined, true)
      changeRemoveActiveButton()
  })
  do_search()
  setTimeout(hideNoticeAndError, 10000)

  $(index_page).find("#csvsubmit").click(sendCsvForm)

#Makes a search
do_search = ->
  searcher.search()

#Changes the places between the remove and active buttons depending on whether deleted or active members are being shown
changeRemoveActiveButton = ->
  button = $(index_page).find("#delete_active_form").find("button")
  if $(index_page).find(".active_menu").find("input").is(":checked")
    button.text("Aktivoi")
  else
     button.text("Poista")

#Sets a table's th as visible or hidden depending on whether a checkbox is checked
setTableColumns = (checkbox)->
  th = $(index_page).find("#members").find("table").find("."+$(checkbox).attr("name"))
  if $(checkbox).is(":checked")
    th.removeClass("hidden")
  else
    th.addClass("hidden")

#Sets a table column as visible or hidden based on whether a checkbox is checked
showHideColumn = (checkbox) ->
  $(index_page).find("#members").find("table").find("." + $(checkbox).attr("name")).each (index, item) ->
    if $(item).hasClass("hidden")
      $(item).removeClass("hidden")
    else
      $(item).addClass("hidden")

#Makes a search if e is enter
enterSearch = (e) ->
  if e.which == 13
    do_search()

#Hides all notices everywhere and all errors on the index page
hideNoticeAndError = ->
  $("#notice").hide().text("")
  $(index_page).find(".error").hide().text("")

#Checks or unchecks all checkboxes for all members
un_select_all_mmembers = (e) ->
  checkboxs = $("#index_member_page").children("#centered").children("#members").find("table").find("tr").find("td").find(":checkbox")
  check_state = $(e.target).is(":checked")
  $(checkboxs).each( (index, value) ->
    $(value).attr("checked", check_state)
  )

#Sends a form inside which the pressed button is.
# If the button has a confirm-field, the action has to be confirmed by the user.
# Collects the chosen members in a form in a hidden field in JSON-form before sending.
# If no members has been chosen, the form is not sent and a notice of this is shown
sendForm = (e) ->
  e.preventDefault()
  if $(e.target).hasClass("confirm") && !confirm("Oletko varma?")
    return false
  checkboxs = $(index_page).find("#members").find("table").find("td").find(":checkbox")
  ids = []
  $(checkboxs).each (index, value) ->
    checkbox = $(value)
    if !!checkbox.is(":checked") && checkbox.attr("name") != "check_all"
      ids.push checkbox.val()
  form = $(e.target).parent("form")
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

sendCsvForm = (e) ->
  e.preventDefault()
  if $(index_page).find("#csvimport").val() == ""
    alert("Valitse ensin tiedosto")
    return false
  $(e.target).parent().submit()

#Removes a row from a table when a button is pressed, and from a form in the table's data-form field
deleteRow = (e) ->
  e.preventDefault
  id = $(e.target).data("id")
  $($(e.target).parent("td").parent("tr").parent("tbody").parent("table").data("form")).find(".member_" + id).remove()
  $(e.target).parent("td").parent("tr").remove()

#Removes a row from a table in the reminder page and reminder_form
deleteRow2 = (e) ->
  e.preventDefault
  id = $(e.target).data("id")
  $(e.target).parent("td").parent("tr").remove()
  reminder.find("#reminder_form").find(".member_" + id).remove()

#Ensures that the e-mail address is in the right format and shows an error message if not
checkEmail = (e) ->
  e.preventDefault
  sender =  $(mailer.find("#mailer_form").find("#senderarea").find("#sender")).val()

  if sender.match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
    $(mailer.find("#mailer_form")).submit()

  else
    alert("Antamasi sähköpostiosoite on virheellinen")
  return false
