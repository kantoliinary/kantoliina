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
/**
 * Sets a given name-value variable to cookies
 */
function SetCookie(name, value) {
    document.cookie = name + "=" + value
}
/**
 * Reads a cookie with a name matching the given parameter
 */
function readCookie(name) {
    name += '=';
    for (var ca = document.cookie.split(/;\s*/), i = ca.length - 1; i >= 0; i--)
        if (!ca[i].indexOf(name))
            return ca[i].replace(name, '');
}
/**
 *  Deletes cookies
 */
function resetCookie(){
    document.cookie = ""
}
/**
 *  Creates a prototype that searches for a given object from an array
 */
Array.prototype.contains = function (obj) {
    var i = this.length;
    while (i--) {
        if (this[i] == obj) {
            return true;
        }
    }
    return false;
}
/**
 * Creates a prototype that sorts an array. Uses a given function for comparison
 * @param comparisor
 */
Array.prototype.sorter = function (comparisor) {
    for (var i = 1; i < this.length; i++) {
        var u = i
        while (u > 0 && comparisor(this[u - 1], this[u])) {
            u--
            var help = this[u]
            this[u] = this[u + 1]
            this[u + 1] = help
        }
    }
}
/**
 * Creates a prototype that sorts a two-dimensional array based on the first values
 * @param comparisor
 */
Array.prototype.columnsort = function (comparisor) {
    this.sorter(function (a, b) {
        return a[0] > b[0]
    })
}
/**
 * Creates a prototype that sorts a two-dimensional array in a reverse order based on the first values
 * @param comparisor
 */
Array.prototype.columnsortreverse = function () {
    this.sorter(function (a, b) {
        return a[0] < b[0]
    })
}
console.log(document.cookie)
