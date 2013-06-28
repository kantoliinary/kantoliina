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
     * previous, according to which the last ordering was made
     * reversed järjestettiinkö edellisellä kertaa väärinpäin.
     * except listaa tulee ne th:n classit minkä mukaan ei haluta järjestää.
     */
    var settings = {}

    /**
     * Asettaa settingsit oikein. Kutsuu readcookies ja käy kaikki tablen ensimmäisen tr:n th:t läpi ja asettaa vasenmman klikkauksen niille jotka eivät ole except listassa.
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
     * Järjestää tablen. Saa joko parametrinä tai hakee asetuksista minkä sarakkeen mukaan table järjestetään. Lataa kaikki tablen rivit taulukkoon ja käyttää arrayn columnsort tai columnsortreverseä
     * Jos same parametri on true järjestetään taulu samaan järjestykseen kuin edellisellä kertaa. Jos taas same on false niin rivit järjestetään käänteisesti jos järjestävä sarake ei vaihtunut taas jos sarake vaihtui niin järjestys on normaali.
     * column parametri vaikuttaa aina siihen minkä sarakkeen mukaan table järjestetään.
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
     * Asettaa jäjrjestetyn arrayn tableen. Poistaa ensin vanhat tiedot tablesta.
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
     * Kutsuu setCookie funktiota settingsin previous ja reversed muuttujilla.
     */
    function setcookies() {
        SetCookie("sortprevious", settings.previous)
        SetCookie("sortreversed", settings.reversed)
    }

    /**
     * Lukee previous ja reversed muuttujat cookiesista.
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
     * Palauttaa olion jossa on init ja sort funktiot.
     */
    return {
        init: init,
        sort: sort
    }
})();