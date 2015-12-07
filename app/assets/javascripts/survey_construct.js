$(document).on('click', '.add_question', function () {
    var question_types = ["Radio", "Checkbox", "Text", "Slider"];
    var questions = parseInt(get_max_index_of_questions(this)) + 1;
    var address = 'survey[questions_attributes][' + questions + ']';
    var content = '<div class="QuestionBlock">' +
        '<label for="sqa_' + questions + '_content">Question</label><br/>' +
        '<input class="question" type="text" name="' + address + '[content]" ' +
        'id="sqa_' + questions + '_content" required="required" />' +
        '<a id="sqa_' + questions + '_content_remove" class="remove_item" href="#">Remove</a><br>' +
        '<select name="' + address + '[option]" id="sqa_' + questions + '_option" class="question_type">';
    for (var i = 0; i < question_types.length; i++)
        content += '<option value="' + (i + 1) + '">' + question_types[i] + '</option>';
    content += '</select><br>' +
        '<div class="answers">' +
        '<ol></ol>' +
        '</div>' +
        '<a id="sqa_' + questions + '_answer_add" class="add_answer" href="#">Add Answer</a><br>' +
        '<hr style="border-color: black;">' +
        '</div>';
    $(content).insertBefore($('.add_question'));
});

$(document).on('click', '.add_answer', function () {
    var question_type = $(this).parent().find('.question_type').val();
    var check = ($(this).parent().find('.answers .answer').attr('id') == undefined);
    var index = parseInt(get_max_index_of_answers(this));
    if ((question_type == 1 || question_type == 2 || question_type == 4 && check )) {
        $(this).parent().find('.answers ol').append(
            generate_answer_html(question_type, index, $(this).parent().find('.question_type').attr('name')));
    }
});

$(document).on('click', '.clickable-area', function () {
    window.document.location = $(this).data("href");
});

$(document).on('mouseover', '.clickable-area', function () {
    $('.clickable-area').css('cursor', 'pointer');
});


$(document).on('click', '.survey_submit', function (e) {
    var slider_present = false;
    $(document).find('input.answer.slider').each(function () {
        if ($(this).prop('id') != undefined)
            slider_present = true;
    });
    if (slider_present) {
        var d = [];
        var i = 0;
        $(document).find('input.answer.slider').each(function () {
            d[i] = parseFloat($(this).val());
            $(this).val(d[i]);
            i += 1;
        });
        if (!(d[0] <= d[2] && d[2] <= d[1])) {
            alert("Wrong slider values!");
            e.preventDefault();
        }
    }
});

function get_max_index_of_answers(obj) {
    var max_index = 0;
    $(obj).parent().find('.answers .answer').each(function () {
        var current_index = $(this).attr('name');
        current_index = current_index.substring(current_index.indexOf('answers_attributes') + 20, current_index.length - 10);
        if (current_index > max_index) max_index = current_index;
    });
    return max_index;
}

function get_max_index_of_questions(obj) {
    var max_index = 0;
    $(obj).parent().find('.question').each(function () {
        var current_index = $(this).attr('name');
        current_index = current_index.substring(current_index.indexOf('questions_attributes') + 22, current_index.length - 10);
        if (current_index > max_index) max_index = current_index;
    });
    return max_index;
}

function generate_answer_html(question_type, index, name) {
    var survey_index = name.substring(29, (name.length - 9));
    var new_survey_index = index + 1;
    var inner_address = 'survey[questions_attributes][' + survey_index + ']';
    var id = 'sqa_' + survey_index + '_a_' + new_survey_index;
    var inner_content = '<label for="' + id + '">Answer</label>' +
        '<input class="answer" type="text" name="' + inner_address + '[answers_attributes][' + new_survey_index + '][content]" ' +
        'id="' + id + '" required="required"/>' +
        '<a id="' + id + '_remove" class="remove_item" href="#">Remove</a>';
    var ready_content;
    if (question_type == 1 || question_type == 2) {
        ready_content = $('<li>' + inner_content + '</li>');
    }
    else if (question_type == 3) {
        ready_content = $('<h5>' + inner_content + '</h5>');
    }
    else if (question_type == 4) {
        var labels = ['Min Answer', 'Max Answer', 'Default value'];
        ready_content = '<h5>';
        for (var i = 0; i < labels.length; i++) {
            var id = 'sqa_' + survey_index + '_a_' + i;
            ready_content += '<label for="' + id + '">' + labels[i] + '</label>' +
                '<input class="answer slider" type="text" name="' + inner_address + '[answers_attributes][' + i + '][content]" ' +
                'id="' + id + '" /><br/>';
        }
        ready_content += '<a id="' + id + '0_remove" class="remove_item" href="#">Remove</a></h5>';
    }
    return $(ready_content);
}

$(document).on('change', '.question_type', function () {
    $(this).parent().find('.answers').replaceWith('<div class="answers"><ol></ol></div>');
});

$(document).on('click', '.remove_item', function () {
    var hidden = $(this).parent().next('input');
    $(this).parent().remove();
    $(hidden).remove();
});

$(document).on('ajax:success', '.remove_item', function () {
    $(this).parent().next().remove();
    $(this).parent().slideUp("normal", function () {
        $(this).remove();
    });
});