/**
 * Shows and hides a list of checkboxes
 * The template must be in a following form:
 *  %div{:class => "multiselectmenu"}
 *      %div{:class => "header"}
 *          #The element opening the dropdown menu
 *      %div{:class => "choices"}
 *          #A list of checkboxes
 * It is possible to add a new checkbox to the list with an id "select_all", which enables the user to check or uncheck the new checkbox along with every other checkbox
 * Returns an object which has an init-function
 * @type {Function}
 */
var multiselect = (function () {

    /**
     * Default settings
     */
    var defaults = {
        elements: [],
        contextmenu: false,
        initItemCallback: function (checkbox) {
        },
        itemCallback: function (checkbox) {
        },
        callback: function (menu) {
        }
    }
    /**
     * Settings
     * Elements that open a dropdown menu when they are clicked are set in variable "elements". The default is empty
     * contextmenu tells whether a dropdown menu is opened with a left or right mouse click. The default is left
     * initItemCallback is a function which is called individually for every checkbox after loading the settings of the checkbox
     * itemCallback is a function which is called when any checkbox is checked or unchecked, except select_all
     * callback is a function which is called when a dropdown menu is closed
     * @type {{elements: Array, contextmenu: boolean, initItemCallback: Function, itemCallback: Function, callback: Function}}
     */
    var settings = {}

    /**
     * Sets the right settings and calls loopMenus-method. Settings are taken from the options-variable and the rest from defaults-variable
     * @param options
     */
    function init(options) {
        settings = $.extend({}, defaults, options)
        loopMenus()
    }

    /**
     * Goes through the menus given in settings, calls loopCheckboxs, setSelectAll and bindOpen for all menus
     */
    function loopMenus() {
        $(settings.elements).each(function (index, item) {
            loopCheckboxs(item)
            setSelectAll(item)
            bindOpen(item)
        })
    }

    /**
     * Sets the dropdown menu to open on a left or right click. Creates a transparent template covering the whole page, which closes the menu when clicked
     * @param menu
     */
    function bindOpen(menu) {
        $(menu).find(".header").bind((settings.contextmenu ? "contextmenu" : "click"), function (e) {
            e.preventDefault()
            choices = $(this).parent().find(".choices")
            $("<div />", {
                id: "hide_layout"
            }).appendTo($("body")).click(function (e) {
                    closeMenu(menu)
                })
            choices.show()
        })
    }

    /**
     * Hides the menu and removes the transparent template that covers the page. Calls the callback function of settings
     * @param menu
     */
    function closeMenu(menu) {
        choices = $(menu).find(".choices")
        choices.hide()
        $("#hide_layout").remove()
        settings.callback(menu)
    }

    /**
     * Goes through all checkboxes in a given menu and sets them the right click. If a matching checkbox is found from cookies, sets the checkbox checked or unchecked according to cookies
     * Calls the itemCallback function when the checkbox is checked or unchecked and after that ? Ja asetuksten jälkeen kutsuu initItemCallback.
     * @param menu
     */
    function loopCheckboxs(menu) {
        var checkboxs = findCheckboxs(menu)
        $(checkboxs).each(function (index, checkbox) {
            var check = readCookie($(checkbox).attr("name"))
            if (check != undefined) {
                $(checkbox).attr("checked", check == 1)
            }
            $(checkbox).click(function (e) {
                setcookie(e.target)
                settings.itemCallback(e.target)
            })
            settings.initItemCallback(checkbox)
        })
    }

    /**
     * If a menu has a select_all -type checkboxes, goes through the checkboxes and sets fields as chosen or not chosen according to them. Sets left click to select_all field which calls selectUnAll
     * @param menu
     */
    function setSelectAll(menu) {
        var select_all = $(menu).find("#select_all")
        if (select_all.length > 0) {
            var all_checked = true
            $(findCheckboxs()).each(function (index, checkbox) {
                if (!$(checkbox).is(":checked")) {
                    all_checked = false
                }
            })
            $(menu).find("#select_all").attr("checked", all_checked)
            select_all.click(function () {
                selectUnAll(menu)
            })
        }
    }

    /**
     * Searches all checkboxes from the menu except select_all
     * @param menu
     * @returns {*|jQuery}
     */
    function findCheckboxs(menu) {
        return $(menu).find(".choices").find(":checkbox").not("#select_all")
    }

    /**
     * Checks or unchecks all checkboxes depending whether the select_all checkbox is checked
     * @param sACheckbox
     */
    function selectUnAll(menu) {
        check_state = $(menu).find("#select_all").is(":checked")
        findCheckboxs(menu).each(function (index, checkbox) {
            $(checkbox).attr("checked", check_state)
        })
    }

    /**
     * Calls setCookie with the state of a given checkbox given as a parameter
     * @param e
     */
    function setcookie(e) {
        SetCookie($(e).attr("name"), ($(e).is(":checked") ? "1" : "0"))
    }

    return {
        init: init
    }
})