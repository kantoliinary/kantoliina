var multiselect = (function () {
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
    var settings = {}

    function init(options) {
        settings = $.extend({}, defaults, options)
        loopElements()
    }

    function loopElements(bind) {
        $(settings.elements).each(function (index, item) {
            loopCheckbox(item)
            setSelectAll(item)
            bindOpen(item)
        })
    }

    function bindOpen(menu) {
        $(menu).find(".header").bind((settings.contextmenu ? "contextmenu" : "click"), function (e) {
            e.preventDefault()
            choices = $(this).parent().find(".choices")
            choices.toggle()
            if (choices.css("display") == "none") {
                settings.callback(menu)
            }
        })
    }

    function loopCheckbox(menu) {
        var checboxs = findCheckboxs(menu)
        $(checboxs).each(function (index, checkbox) {
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

    function setSelectAll(menu) {
        var select_all = $(menu).find(".choices").find("#select_all")
        if (select_all) {
            select_all.click(function () {
                select_Un_All(select_all)
            })
        }
    }

    function findCheckboxs(menu) {
        return $(menu).find(".choices").find(":checkbox").not(":has(#select_all")
    }

    function select_Un_All(sACheckbox) {
        check_state = sACheckbox.is(":checked")
        sACheckbox.parent().parent().find(":checkbox").not(":has(#select_all").each(function (index, checkbox) {
            $(checkbox).attr("checked", check_state)
        })
    }

    function setcookie(e) {
        SetCookie($(e).attr("name"), ($(e).is(":checked") ? "1" : "0"))
    }

    return {
        init: init
    }
})