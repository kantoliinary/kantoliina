var sorter = (function (options) {
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
        $(settings.table).find("tr:first").find("th").each(function (index, item) {
            $(item).click(function () {
                sort(index, false)
            })
        })
    }

    function sort(column, same) {
        if(!column){
            column = settings.previous
        }
        if(!column){
            return;
        }

        var rows = []
        $(settings.table).find("tr").not(":first").each(function (index, tr) {
            rows.push([$(tr).find("td:eq(" + column + ")").text(), tr])
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
            settings.reverse = reverse
        }
    }

    return {
        init: init,
        sort: sort
    }
})();