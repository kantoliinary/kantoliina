var search = (function (){
    var defaults = {
        url: "/members/search",
        searchfield: "searchfield",
        selectgroups: [],
        outputtable: "",
        outputlengthfield: "",
        column_menu: "",
        callback: function(){}
    }

    var settings = {}
    function init(options){
        settings = $.extend({}, defaults, options)
    }

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

    function findCheckboxs(menu){
        return $(menu).find(":checkbox").not("#select_all")
    }

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

    function getVisibleColumns(){
        var visible_columns = []
        $(settings.column_menu).find(":checkbox").each(function(index, item){
            if($(item).is(":checked")){
                visible_columns.push($(item).attr("name"))
            }
        })
        return visible_columns
    }

    function clearOldData(){
        $(settings.outputtable).find("tr").each(function (index, item) {
            if (!$(item).has("th").length) {
                $(item).remove()
            }
        })
    }
    return {
        init: init,
        search: search
    }
})