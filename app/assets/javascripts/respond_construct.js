$(document).ready(
    $(function () {

        var min = parseInt($("#slider_min").attr("class"));
        var def = parseInt($("#slider_def").attr("class"));
        var max = parseInt($("#slider_max").attr("class"));

        $("#slider-range").slider({
            range: "min",
            min: min,
            step: 0.01,
            max: max,
            value: def,
            slide: function (event, ui) {
                $("#amount").val(ui.value);
            }
        });
        $("#amount").val($("#slider-range").slider("value"));
    })
)


$(document).on('click', '.respond_submit', function (e) {
    var flag = false;
    var checkbox_present=false;
    $(document).find('input#checkbox').each(function () {
        if ($(this).prop('checked'))       flag = true;
        if ($(this).prop('id')!=undefined)       checkbox_present = true;
    });
    if (!flag&&checkbox_present) {
        alert("You must to pick something from checkbox answers!");
        e.preventDefault();
    }
})