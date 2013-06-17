/**
 * Created with JetBrains RubyMine.
 * User: tanelvir
 * Date: 17.6.2013
 * Time: 11:50
 * To change this template use File | Settings | File Templates.
 */
    do_random()
do_random = ->
    random({
        $.rand = function(arg) {
            if ($.isArray(arg)) {
                return arg[$.rand(arg.length)];
            } else {
                return 1;
            }
        }
    })