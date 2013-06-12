var multiselect = function (options, itemcallback, callback) {
    var defaults = {
        elements: [],
        contextmenu: false,
        callback: function (checkbox) {
        }
    }
    var settings = $.extend({}, defaults, options)
    var bind = (settings.contextmenu ? "contextmenu" : "click")
    $(settings.elements).each(function (index, item) {
        var checboxs = $(item).find(".choices").find(":checkbox")
        $(checboxs).each(function (index, checkbox) {
            if (readCookie($(checkbox).attr("name")) != undefined) {
                $(checkbox).attr("checked", readCookie($(checkbox).attr("name")) == 1)
            }
            settings.callback(checkbox)
            $(checkbox).click(function (e) {
                setcookie(e.target)
                if (itemcallback != null) {
                    itemcallback(e.target)
                }
            })
        })
        $(item).find(".header").bind(bind, function (e) {
            e.preventDefault()
            choices = $(this).parent().find(".choices")
            choices.toggle()
            if (choices.css("display") == "none" && callback != null) {
                callback(this)
            }
        })
    })

    function setcookie(e) {
        SetCookie($(e).attr("name"), ($(e).is(":checked") ? "1" : "0"))
    }
}