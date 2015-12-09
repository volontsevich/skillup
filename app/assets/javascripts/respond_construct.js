$(document).ready(
    $(function () {
        var $sliderInput=$('#slider-input');
        var $min = $sliderInput.data('min');
        var $def = $sliderInput.data('def');
        var $max = $sliderInput.data('max');
        $("#slider-range").slider({
            range: "min",
            min: $min,
            step: 1,
            max: $max,
            value: $def,
            slide: function (event, ui) {
                $("#amount").val(ui.value);
            }
        });
        $("#amount").val($("#slider-range").slider("value"));
    })
)

$(document).on('click', '.respond_submit', function (e) {
    var $is_something_checked = false;
    if ($(document).find('input#checkbox').length != 0) {
        $(document).find('input#checkbox').each(function () {
            if ($(this).prop('checked'))
                $is_something_checked = true;
        });
        if (!$is_something_checked) {
            alert("You must to pick something from checkbox answers!");
            e.preventDefault();
        }
    }
})