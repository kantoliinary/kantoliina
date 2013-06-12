var multiselect = function (options, itemcallback, callback) {
    var defaults = {
        elements: [],
        contextmenu: false
    }
    var settings = $.extend({}, defaults, options)
    var bind = (settings.contextmenu ? "contextmenu" : "click")
    $(settings.elements).each(function (index, item) {
        $(item).find(".header").bind(bind, function (e) {
            e.preventDefault()
            choices = $(this).parent().find(".choices")
            choices.toggle()
            if (choices.css("display") == "none" && callback != null) {
                callback(this)
            }
        })
        $(item).find(".choices").find("input").click(function () {
            if (itemcallback != null) {
                itemcallback(this)
            }
        })
    })
}

