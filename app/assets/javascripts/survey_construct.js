var $question_types = {"Radio": 1, "Checkbox": 2, "Text": 3, "Slider": 4};

$(document).on('click', '.add_question', function () {
    var $questions = parseInt(get_max_index_of_questions(this)) + 1;
    var $address = 'survey[questions_attributes][' + $questions + ']';
    var $content = '<div class="QuestionBlock">' +
        '<label for="sqa_' + $questions + '_content">Question</label><br/>' +
        '<input class="question" type="text" name="' + $address + '[content]" ' +
        'id="sqa_' + $questions + '_content" required="required" />' +
        '<a id="sqa_' + $questions + '_content_remove" class="remove_item" href="#">Remove</a><br>' +
        '<select name="' + $address + '[option]" id="sqa_' + $questions + '_option" class="question_type">';
    $.each($question_types, function ($k, $v) {
        $content += '<option value="' + $v + '">' + $k + '</option>';
    });
    $content += '</select><br>' +
        '<div class="answers">' +
        '<ol></ol>' +
        '</div>' +
        '<a id="sqa_' + $questions + '_answer_add" class="add_answer" href="#">Add Answer</a><br>' +
        '<hr style="border-color: black;">' +
        '</div>';
    $($content).insertBefore($('.add_question'));

    //_.templateSettings = {
    //    interpolate: /\{\{=(.+?)\}\}/g,
    //    escape: /\{\{-(.+?)\}\}/g,
    //    evaluate: /\{\{(.+?)\}\}/g,
    //};
    //
    //var template = _.template('<div class="QuestionBlock"><label for="sqa_{{-a}}_content">Que{{-b}}stion</label>');
    //$('#pancakes').html(template({a: $questions, b: 's'}));
});

$(document).on('click', '.add_answer', function () {
    var $question_type = $(this).parent().find('.question_type').val();
    var $slider_present = false;
    if ($question_type == $question_types["Slider"])
        $slider_present = ($(this).parent().find('.answers .answer.slider').attr('id') != undefined);
    var $index = parseInt(get_max_index_of_answers(this));
    if (($question_type == $question_types["Radio"] || $question_type == $question_types["Checkbox"] ||
        $question_type == $question_types["Slider"] && !$slider_present )) {
        $(this).parent().find('.answers ol').append(
            generate_answer_html($question_type, $index, $(this).parent().find('.question_type').attr('name')));
    }
});

$(document).on('click', '.add_email', function () {
    var $index = parseInt(get_max_index_of_emails(this));
    $(this).parent().find('.emails ol').append(generate_email_html($index));
});

$(document).on('click', '.clickable-area', function () {
    window.document.location = $(this).data("href");
});

$(document).on('mouseover', '.clickable-area', function () {
    $('.clickable-area').css('cursor', 'pointer');
});

$(document).on('click', '.survey_submit', function ($e) {
    var $slider_present = false;
    $(document).find('input.answer.slider').each(function () {
        if ($(this).prop('id') != undefined)
            $slider_present = true;
    });
    if ($slider_present) {
        var $d = [];
        var $i = 0;
        $(document).find('input.answer.slider').each(function () {
            $d[$i] = parseFloat($(this).val());
            $(this).val($d[$i]);
            $i += 1;
        });
        if (!($d[0] <= $d[2] && $d[2] <= $d[1])) {
            alert("Wrong slider values!");
            $e.preventDefault();
        }
    }
});

function get_max_index_of_questions($obj) {
    return get_max_index_of_items($obj, '.question', 'questions_attributes');
}

function get_max_index_of_answers($obj) {
    return get_max_index_of_items($obj, '.answers .answer', 'answers_attributes');
}

function get_max_index_of_emails($obj) {
    return get_max_index_of_items($obj, '.emails .email', 'survey_mails_attributes');
}

function get_max_index_of_items($obj, $class_name, $attributes_name) {
    var $max_index = 0;
    $($obj).parent().find($class_name).each(function () {
        var $current_index = $(this).attr('name');
        $current_index = $current_index.substring($current_index.indexOf($attributes_name) +
            ($attributes_name.length + 2), $current_index.length - 10);
        if ($current_index > $max_index) $max_index = $current_index;
    });
    return $max_index;
}

function generate_email_html($index) {
    return $('<li><label for="survey_survey_mails_attributes_' + ($index + 1) + '_address">Address</label>' +
        '<input class="email" name="survey[survey_mails_attributes][' + ($index + 1) + '][address]"' +
        ' id="survey_survey_mails_attributes_' + ($index + 1) + '_address" type="text">' +
        '<a class="remove_item" id="remove_email_' + ($index + 1) + '" href="#">Remove</a>' +
        '</li>');
}

function generate_answer_html($question_type, $index, $name) {
    var $survey_index = $name.substring(29, ($name.length - 9));
    var $new_survey_index = $index + 1;
    var $inner_address = 'survey[questions_attributes][' + $survey_index + ']';
    var $id = 'sqa_' + $survey_index + '_a_' + $new_survey_index;
    var $inner_content = '<label for="' + $id + '">Answer</label>' +
        '<input class="answer" type="text" name="' + $inner_address + '[answers_attributes][' + $new_survey_index + '][content]" ' +
        'id="' + $id + '" required="required"/>' +
        '<a id="' + $id + '_remove" class="remove_item" href="#">Remove</a>';
    var $ready_content = '';
    if ($question_type == $question_types["Radio"] || $question_type == $question_types["Checkbox"]) {
        $ready_content = $('<li>' + $inner_content + '</li>');
    }
    else if ($question_type == $question_types["Slider"]) {
        var $labels = ['Min Answer', 'Max Answer', 'Default value'];
        for (var $i = 0; $i < $labels.length; $i++) {
            var $id = 'sqa_' + $survey_index + '_a_' + $i;
            $ready_content += '<li><label for="' + $id + '">' + $labels[$i] + '</label>' +
                '<input class="answer slider" type="text" name="' + $inner_address + '[answers_attributes][' + $i + '][content]" ' +
                'id="' + $id + '" /></li>';
        }
        $ready_content += '<a id="' + $id + '0_remove" class="remove_item" href="#">Remove</a></h5>';
    }
    return $($ready_content);
}

$(document).on('change', '.question_type', function () {
    $(this).parent().find('.answers').replaceWith('<div class="answers"><ol></ol></div>');
});

$(document).on('click', '.remove_item', function () {
    var $hidden = $(this).parent().next('input');
    if ($(this).parent().find('.slider').attr('id') != undefined)
        $(this).parent().parent().append('<ol></ol>');
    $(this).parent().remove();
    $($hidden).remove();
});

$(document).on('ajax:success', '.remove_item', function () {
    $(this).parent().next().remove();
    $(this).parent().slideUp("normal", function () {
        $(this).remove();
    });
});