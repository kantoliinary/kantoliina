/**
 * Näytää ja piilottaa listan checkboxeista.
 * Pohjan tulee olla seuraavassa muodossa:
 *  %div{:class => "multiselectmenu"}
 *      %div{:class => "header"}
 *          #Valikon avaava elementti
 *      %div{:class => "choices"}
 *          #Lista checkboxeista
 * Checkboxeihin voi lisätä checkboxin id:llä "select_all", joka valitsee tai poistaa valinnat kaikista checkboxeista
 * Palauttaa olion jolla init funktio.
 * @type {Function}
 */
var multiselect = (function () {

    /**
     * Default asetukset.
     */
    var defaults = {
        elements: [],
        contextmenu: false,
        initItemCallback: function (checkbox) {
        },
        itemCallback: function (checkbox) {
        },
        callback: function (menu) {
        }
    }
    /**
     * Asetukset
     * Elementit joista valikko avataan asetetaan elements muuttujaan. Default: tyhjä.
     * contextmenu kertoo avataanko valikko oikealla vai vasemmalla hiiren klikkauksella. Dedault: vasen.
     * initItemCallback on funktio jota kutsutaan jokaisen checkboxin asetusten latauksen jälkeen.
     * itemCallback on funktion jota kutsutaan kun jotain checkboxia klikataan. Paitsi select all.
     * callback on funktio jota kutsutaan kun valikko suljetaan.
     * @type {{elements: Array, contextmenu: boolean, initItemCallback: Function, itemCallback: Function, callback: Function}}
     */
    var settings = {}

    /**
     * Asettaa oikeat asetukset ja kutsuu loopMenus. Asetukset otetaan options muuttujasta ja loput dedaults muuttujasta.
     * @param options
     */
    function init(options) {
        settings = $.extend({}, defaults, options)
        loopMenus()
    }

    /**
     * Käy läpi asetuksiin annetut valikot. Kutsuu loopCheckboxs, setSelectAll ja bindOpen kaikille valikoille.
     */
    function loopMenus() {
        $(settings.elements).each(function (index, item) {
            loopCheckboxs(item)
            setSelectAll(item)
            bindOpen(item)
        })
    }

    /**
     * Asettaa valikon avautumaan joko vasemmalla tai oikealla klikkauksella. Luo koko sivun täyttävän läpi näkyvän pohjan jota klikkaamalla valikko sulkeutuu.
     * @param menu
     */
    function bindOpen(menu) {
        $(menu).find(".header").bind((settings.contextmenu ? "contextmenu" : "click"), function (e) {
            e.preventDefault()
            choices = $(this).parent().find(".choices")
            $("<div />", {
                id: "hide_layout"
            }).appendTo($("body")).click(function (e) {
                    closeMenu(menu)
                })
            choices.show()
        })
    }

    /**
     * Piilottaa valikon ja poistaa sivun kattavan läpinäkyvän pohjan. Kutsuu settingsin callback funktiota.
     * @param menu
     */
    function closeMenu(menu) {
        choices = $(menu).find(".choices")
        choices.hide()
        $("#hide_layout").remove()
        settings.callback(menu)
    }

    /**
     * Käy läpi annetun valikon checkboxit ja asettaa niille vasemman klikkauksen. Jos löytää cookiesista vastaavan asettaa sen mukaan valituksi tai ei valituksi.
     * Klikattaessa kutsuu itemCallback funktiota. Ja asetuksten jälkeen kutsuu initItemCallback.
     * @param menu
     */
    function loopCheckboxs(menu) {
        var checkboxs = findCheckboxs(menu)
        $(checkboxs).each(function (index, checkbox) {
            var check = readCookie($(checkbox).attr("name"))
            if (check != undefined) {
                $(checkbox).attr("checked", check == 1)
            }
            $(checkbox).click(function (e) {
                setcookie(e.target)
                settings.itemCallback(e.target)
            })
            settings.initItemCallback(checkbox)
        })
    }

    /**
     * Jos valikolla on select all checkbox, käy valinnat läpi ja asettaa kentän valituksi tai ei valituksi sen mukaan. Asettaa select all kentälle vasemman klikkauksen joka kutsuu selectUnAll.
     * @param menu
     */
    function setSelectAll(menu) {
        var select_all = $(menu).find("#select_all")
        if (select_all.length > 0) {
            var all_checked = true
            $(findCheckboxs()).each(function (index, checkbox) {
                if (!$(checkbox).is(":checked")) {
                    all_checked = false
                }
            })
            $(menu).find("#select_all").attr("checked", all_checked)
            select_all.click(function () {
                selectUnAll(menu)
            })
        }
    }

    /**
     * Etsii kaikki menun checkboxsit lukuunottamatta select all.
     * @param menu
     * @returns {*|jQuery}
     */
    function findCheckboxs(menu) {
        return $(menu).find(".choices").find(":checkbox").not("#select_all")
    }

    /**
     * Valitsee tai poistaa valinnat kaikista valikon checkboxeista riippuen select all checkboxin tilasta.
     * @param sACheckbox
     */
    function selectUnAll(menu) {
        check_state = $(menu).find("#select_all").is(":checked")
        findCheckboxs(menu).each(function (index, checkbox) {
            $(checkbox).attr("checked", check_state)
        })
    }

    /**
     * Kutsuu setCookie annetun checkboxin tiedoilla.
     * @param e
     */
    function setcookie(e) {
        SetCookie($(e).attr("name"), ($(e).is(":checked") ? "1" : "0"))
    }

    return {
        init: init
    }
})