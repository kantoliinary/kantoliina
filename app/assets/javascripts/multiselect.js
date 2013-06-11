var multiselect = function (element, options, itemcallback, callback) {
    var defaults = {
        contextmenu: false
    }
    var settings = $.extend({}, defaults, options)
    var bind = (settings.contextmenu ? "contextmenu" : "click")
    $(element).find(".header").bind(bind, function (e) {
        e.preventDefault()
        choices = $(this).parent().find(".choices")
        choices.toggle()
        if (choices.css("display") == "none" && callback != null) {
            callback(this)
        }
    })
    $(element).find(".choices").find("input").click(function () {
        if (itemcallback != null) {
            itemcallback(this)
        }
    })
}

