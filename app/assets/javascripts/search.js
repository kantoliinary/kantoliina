/**
 * Tekee haun serveriltä annetuilla tiedoilla.
 * @type {Function}
 */
var search = (function (){
    /**
     * Dedault asetukset
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
     * Asetukset.
     * url, johon lähetetään hakutiedot.
     * serarcfield josta haetaan hakusana.
     * selectgroups lista checkbox ryhmistä mitkä otetaan hakuun mukaan
     * outputtable table jossa haun tulokset näytettään
     * outputlengthfield paikka johon haun tulosten määrä laitetaan.
     * column_menu column menun id.
     * callback funktio jota kutsutaan kun ollaan saatu uuden haun tulokset asetettua tauluun.
     */
    var settings = {}

    /**
     * Asettaa options muuttujasta tiedot settings muuttujaan ja lisää defaultit jos jotain puuttui.
     * @param options
     */
    function init(options){
        settings = $.extend({}, defaults, options)
    }

    /**
     * Tekee haun kutsuu hakee haettavat tiedot getData funktiolla ja kutsuu insertData funktiota kun serveri palauttaa tiedot.
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
     * Hakee datan joka lähetetään severille. Hakusana haetaan searchfieldistä mikä annetaan asetuksissa. Asetusten selectgroups käydään läpi ja näistä otetaan mukaan kaikki valitut, paitse select all.
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
     * Valitsee kaikki annetun menun checkboxit paitsi select all.
     * @param menu
     * @returns {*|jQuery}
     */
    function findCheckboxs(menu){
        return $(menu).find(":checkbox").not("#select_all")
    }

    /**
     * Asettaa datan asetuksissa annettuun tableen. Sekä määrän asetuksissa annettuun outputlengthfieldiin.
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
     * Hakee kaikkien näkyvissä olevien sarakkeitten nimet.
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
     * Tyhjentään vanhan datan taulukosta.
     */
    function clearOldData(){
        $(settings.outputtable).find("tr").each(function (index, item) {
            if (!$(item).has("th").length) {
                $(item).remove()
            }
        })
    }

    /**
     * Palauttaa init funktion ja search funktion.
     */
    return {
        init: init,
        search: search
    }
})