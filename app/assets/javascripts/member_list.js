$(document).ready(function (){
    $("#index_member_page #send_invoice").click(function (e){
        e.preventDefault()
        var checkboxs = $("#index_member_page #members").find(":checkbox")
        var ids = []
        $(checkboxs).each(function (index, value){
            var checkbox = $(value);
            if(checkbox.is(":checked") && checkbox.attr("name") != "check_all"){
                ids.push(checkbox.val())
            }
        });
        var object = {
            ids: ids
        }
        var json = JSON.stringify(object)
        var form = $("#index_member_page #invoice_form")
        form.children("#ids").val(json)
        form.submit();
    })
})