/**
 *  Orders a given table and loads the order from cookies
 */
var sorter = (function () {
    /**
     * Default asetukset.
     */
    var defaults = {
        table: "",
        previous: -1,
        reversed: false,
        except: []
    }

    /**
     * Settings
     * table, which is to be ordered
     * previous, according to which the last sort was made
     * reversed, tells if the last sort was made in the reverse order
     * except, lists those table header's classes according to which the elements should not be sorted
     */
    var settings = {}

    /**
     * Sets the settings correctly: calls readcookies and goes through all headers in the first row of the table and sets the left click for those headers not in the except-list
     * @param options
     */
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

    /**
     * Sorts a table: the column according to which the sort is made is taken from the parameters or the settings
     * Loads all table rows to a table and uses the columnsort or columnsortreverse of an array
     * If a matching parameter is true, the table is sorted as it was sorted in the last time
     * If the same-variable is false the rows are sorted in a standard or reverse order according to whether the column dominating the sort has changed
     * column, the parameter defining according to which column the sort is made
     * @param column
     * @param same
     */
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

    /**
     * Deletes the old data from the table and sets the sorted array in the table
     * @param array
     */
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

    /**
     *  Calls SetCookie-function with the previous- and reversed-variables of the settings as parameters
     */
    function setcookies() {
        SetCookie("sortprevious", settings.previous)
        SetCookie("sortreversed", settings.reversed)
    }

    /**
     * Reads the previous- and reversed-variables from cookies
     */
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

    /**
     * Returns the object that includes the init- and sort-functions
     */
    return {
        init: init,
        sort: sort
    }
})();