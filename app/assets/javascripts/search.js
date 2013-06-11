var search = function (options) {
    var defaults = {
        url: "/members/search",
        searchfield: "searchfield",
        selectgroups: [],
        outputtable: "",
        column_menu: ""
    }
    var settings = $.extend({}, defaults, options)
    var data = {
        keyword: $("#" + settings.searchfield).text()
    }
    $(settings.selectgroups).each(function (index, item) {
        var selected = []
        $(item[0]).find(":checkbox").each(function (index, checkbox) {
            if ($(checkbox).attr("checked")) {
                selected.push($(checkbox).attr("name"))
            }
        })
        data[item[1]] = selected
    })
    $.ajax({
        type: "GET",
        url: settings.url,
        dataType: "json",
        data: data,
        success: insertdata
    })
    function insertdata(data, textStatus, jqXHR) {
        var visible_columns = []
        $(settings.column_menu).find(":checkbox").each(function(index, item){
            if($(item).attr("checked")){
                visible_columns.push($(item).attr("name"))
            }
        })
        table = $(settings.outputtable)
        table.find("tr").each(function (index, item) {
            if (!$(item).has("th").length) {
                $(item).remove()
            }
        })
        var columns = ["membernumber", "name", "municipality", "address", "zipcode", "postoffice", "membergroup", "membershipyear", "paymentstatus", "deleted", "lender", "support"]
        var images= ["paymentstatus", "deleted", "lender", "support"]
        $(data).each(function (index, member) {
            var tr = jQuery("<tr/>")
            var td = jQuery("<td/>").appendTo(tr)
            jQuery("<input/>",{
                type: "checkbox",
                class: "checkbox",
                id: "member_"+member.id,
                name: "member_"+member.id,
                value: member.id
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
            tr.appendTo(table)
        })
    }
}