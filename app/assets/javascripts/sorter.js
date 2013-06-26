var sorter = (function () {
    var defaults = {
        table: "",
        previous: -1,
        reversed: false,
        except: []
    }
    var settings = {}

    function init(options) {
        settings = $.extend({}, defaults, options)
        readcookies();
        $(settings.table).find("tr:first").find("th").find("span").each(function (index, item) {
            if(settings.except.contains($(item).attr("class"))){
                return
            }
            $(item).click(function () {
                sort(index, false)
            })
        })
    }

    function sort(column, same) {
        if(column == undefined){
            column = settings.previous
        }  else {
            column++
        }
        if(column == -1){
            return;
        }
        var rows = []
        $(settings.table).find("tr").not(":first").each(function (index, tr) {
            rows.push([$(tr).find("td:eq(" + (column) + ")").text().toLowerCase(), tr])
        })
        if ((same && !settings.reversed) || (!same && (settings.previous != column || settings.reversed))) {
            rows.columnsort()
            settings.reversed = false
        } else {
            rows.columnsortreverse()
            settings.reversed = true
        }
        settings.previous = column
        setcookies()
        insertsortedarray(rows)

    }

    function insertsortedarray(array) {
        var body = $("<tbody/>")
        $(array).each(function (index, item) {
            body.append(item[1])
        })
        $(settings.table).find("tr").not(":first").each(function (index, tr) {
            $(tr).remove()
        })
        $(settings.table).append(body)
    }

    function setcookies() {
        SetCookie("sortprevious", settings.previous)
        SetCookie("sortreversed", settings.reversed)
    }

    function readcookies() {
        previous = readCookie("sortprevious")
        reverse = readCookie("sortreversed")
        if (previous) {
            settings.previous = previous
        }
        if (reverse) {
            settings.reversed = reverse == "true"
        }
    }

//    function print(rows){
//        $(rows).each(function (index, item){
//            console.log(item[0])
//        })
//    }
    return {
        init: init,
        sort: sort
    }
})();