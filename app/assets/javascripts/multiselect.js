var multiselect = function (element, callback){
    $(element).find(".header").click(function(e){
        $(this).parent().find(".choices").toggle()
    })
    $(element).find(".choices").find("input").click(function(){
        callback(this)
    })
}

