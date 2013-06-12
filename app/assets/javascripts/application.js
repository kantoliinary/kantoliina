// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

Array.prototype.contains = function (obj) {
    var i = this.length;
    while (i--) {
        if (this[i] == obj) {
            return true;
        }
    }
    return false;
}

function member_bottom_form_show(e) {
    var checkboxs = $("#index_member_page").find("#members").find(":checkbox")
    $("#bottom_forms").show()
    $(checkboxs).each(function (index, value) {
        var checkbox = $(value)
        if (checkbox.attr("checked")) {
            var checked = true
            return false
        }
    })
    if (!checked) {
        $("#bottom_forms").hide()
    }
}