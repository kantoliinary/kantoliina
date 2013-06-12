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
        $(item).find(".choices").find("input").click(function (e) {
            setcookie(e.target)
            if (itemcallback != null) {
                itemcallback(e.target)
            }
        })
    })
    function setcookie(e){
        SetCookie($(e).attr("name"), ($(e).is(":checked") ? "1" : "0"))
    }
}