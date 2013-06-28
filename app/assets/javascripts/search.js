/**
 * Makes a search from the server with given information
 * @type {Function}
 */
var search = (function (){
    /**
     * Default settings
     */
    var defaults = {
        url: "/members/search",
        searchfield: "searchfield",
        selectgroups: [],
        outputtable: "",
        outputlengthfield: "",
        column_menu: "",
        callback: function(){}
    }

    /**
     * Settings
     * url, where the search information is sent to
     * searchfield, where the keyword is taken from
     * Selectgroups, list of checkbox groups that are included in the search
     * outputtable, a table where the search results are shown
     * outputlengthfield, a variable where the amount of search results is put
     * column_menu, the ID of the column menu
     * callback, a function which is called when the new search results have been set in the table
     */
    var settings = {}

    /**
     * Sets the data from the options-variable to the settings-variable and adds defaults, if something is missing
     * @param options
     */
    function init(options){
        settings = $.extend({}, defaults, options)
    }

    /**
     *  Makes a search that calls the search data with a getData-function and calls insertData-function when the server returns the data
     */
    function search(){
        $.ajax({
            type: "GET",
            url: settings.url,
            dataType: "json",
            data: getData(),
            success: function(data, textStatus, jqXHR){
                insertData(data)
            }
        })
    }

    /**
     * Fetches the data that is sent to the server. The keyword is taken from the searchfield given in the settings.
     * The function goes through the selectgroups-variable of the settings, and all matching membergroups are chosen, except select_all
     * @returns {{keyword: (*|jQuery)}}
     */
    function getData(){
        var data = {
            keyword: $("#" + settings.searchfield).val()
        }
        $(settings.selectgroups).each(function (index, item) {
            var selected = []
            findCheckboxs(item[0]).each(function (index, checkbox) {
                if ($(checkbox).is(":checked")) {
                    selected.push($(checkbox).val())
                }
            })
            data[item[1]] = selected
        })
        return data
    }

    /**
     * Chooses all checkboxes in a given menu except select_all
     * @param menu
     * @returns {*|jQuery}
     */
    function findCheckboxs(menu){
        return $(menu).find(":checkbox").not("#select_all")
    }

    /**
     * Sets the data to the table given in the settings and the size of the table in the outputlength given in the settings
     * @param data
     */
    function insertData(data){
        var columns = ["membernumber", "name", "email", "municipality", "address", "zipcode", "postoffice", "country", "membergroup", "membershipyear", "invoicedate", "reminderdate", "paymentstatus", "active", "support", "lender"]
        var images= ["paymentstatus", "active", "lender", "support"]
        var visible_columns = getVisibleColumns()
        clearOldData()
        $(data).each(function (index, member) {
            var tr = jQuery("<tr/>")
            var td = jQuery("<td/>").appendTo(tr)
            jQuery("<input/>",{
                type: "checkbox",
                class: "member_select_checkbox",
                id: "member_"+member.id,
                name: "member_"+member.id,
                value: member.id,
            }).appendTo(td)
            $(columns).each(function(index, column){
                td = jQuery("<td/>",{
                    class: column+(visible_columns.contains(column) ? "" : " hidden")
                }).appendTo(tr)
                if(images.contains(column)){
                    jQuery("<img/>",{
                        src: "/assets/"+(!!member[column] ? "green-mark" : "x-mark")+".png"
                    }).appendTo(td)
                } else if(column == "membernumber") {
                    jQuery("<a/>",{
                        href: "/members/"+member.id+"/edit",
                        text: member[column]
                    }).appendTo(td)
                } else {
                    td.html(member[column])
                }
            })
            tr.appendTo($(settings.outputtable))
        })
        $(settings.outputlengthfield).html(data.length)
        settings.callback()
    }

    /**
     * Fetches the names of all visible columns
     * @returns {Array}
     */
    function getVisibleColumns(){
        var visible_columns = []
        $(settings.column_menu).find(":checkbox").each(function(index, item){
            if($(item).is(":checked")){
                visible_columns.push($(item).attr("name"))
            }
        })
        return visible_columns
    }

    /**
     * Deletes the old data from a table
     */
    function clearOldData(){
        $(settings.outputtable).find("tr").each(function (index, item) {
            if (!$(item).has("th").length) {
                $(item).remove()
            }
        })
    }

    /**
     * Returns the init- and search-functions
     */
    return {
        init: init,
        search: search
    }
})