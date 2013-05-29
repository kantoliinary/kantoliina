$(document).ready(function () {
    var index = $("#index_member_page")
    index.find("#send_invoice").click(function (e) {
        e.preventDefault()
        var checkboxs = $("#index_member_page #members").find(":checkbox")
        var ids = []
        $(checkboxs).each(function (index, value) {
            var checkbox = $(value);
            if (!!checkbox.attr("checked") && checkbox.attr("name") != "check_all") {
                ids.push(checkbox.val())
            }
        });
        var form = $("#index_member_page #invoice_form")
        form.children("#ids").val(JSON.stringify({
            ids: ids
        }))
        if (ids.length != 0) {
            form.submit();
        }
    })
    index.find("#check_all").click(function () {
        var checkboxs = index.children("#members").find(":checkbox")
        var check_state = !!$(this).attr("checked");
        $(checkboxs).each(function (index, value) {
            $(value).attr("checked", check_state)
        })
    })
})