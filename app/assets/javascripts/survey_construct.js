$(document).on('click', '.add_question', function () {
    var questions = parseInt(get_max_index_of_questions(this)) + 1;
    var address = 'survey[questions_attributes][' + questions + ']';
    $(this).parent().prepend('<div class="QQQ">' +
        '<label for="sqa_' + questions + '_content">Question</label><br/>' +
        '<input class="question" type="text" name="' + address + '[content]" ' +
        'id="sqa_' + questions + '_content" required="required" /><a id="sqa_' + questions + '_content_remove"class="remove_item" href="#">Remove</a>' +
        '<br><select name="' + address + '[option]" id="sqa_' + questions + '_option"class="question_type">' +
        '<option selected="selected" value="1">Radio</option>' +
        '<option value="2">Checkbox</option>' +
        '<option value="3">Text</option>' +
        '<option value="4">Slider</option>' +
        '</select><br>' +
        '<div class="answers"><ol></ol></div>' +
        '<a id="sqa_' + questions + '_answer_add"class="add_answer" href="#">Add Answer</a><br>' +
        '<hr style="border-color: black;"></div>');
});

$(document).on('click', '.add_answer', function () {
    var question_type = $(this).parent().find('.question_type').val();
    var check = ($(this).parent().find('.answers .answer').attr('id') == undefined);
    var index = parseInt(get_max_index_of_answers(this));
    if ((question_type == 1 || question_type == 2 || question_type == 4 && check )) {
        $(this).parent().find('.answers ol').append(get_content(question_type, index, $(this).parent().find('.question_type').attr('name')));
    }
});


$(document).on('click', '.survey_submit', function (e) {
    var d = [];
    var i = 0;
    $(document).find('input.answer.slider').each(function () {
        d[i] = parseFloat($(this).val());
        $(this).val(d[i]);
        i += 1;
    });
    var slider_present = false;
    $(document).find('input.answer.slider').each(function () {
        if ($(this).prop('id') != undefined)       slider_present = true;
    });

    if (slider_present) {
        if (d[0] <= d[2] && d[2] <= d[1]) {
        }
        else {
            alert("Wrong values!");
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


function get_content(question_type, index, name) {
    survey_position = name.substring(29, (name.length - 9));
    var pos = index + 1;
    inner_address = 'survey[questions_attributes][' + survey_position + ']';
    var id = 'sq' + survey_position + '_a_' + pos;

    var inner_content = '<label for="' + id + '">Answer</label>' +
        '<input class="answer" type="text" name="' + inner_address + '[answers_attributes][' + pos + '][content]" ' +
        'id="' + id + '" required="required"/>' +
        '<a id="' + id + '_remove" class="remove_item" href="#">Remove</a>';
    var cont;
    if (question_type == 1) {
        cont = $('<li>' + inner_content + '</li>');
    }
    else if (question_type == 2 || question_type == 3) {
        cont = $('<h5>' + inner_content + '</h5>');
    }
    else {
        var id = 'sq' + survey_position + '_a_';
        cont = $('<h5>' +
            '<label for="' + id + '0">Min Answer</label>' +
            '<input class="answer slider" type="text" name="' + inner_address + '[answers_attributes][0][content]" ' +
            'id="' + id + '0" /><br/>' +
            '<label for="' + id + '1">Max Answer</label>' +
            '<input class="answer slider" type="text" name="' + inner_address + '[answers_attributes][1][content]" ' +
            'id="' + id + '1" /><br/>' +
            '<label for="' + id + '2">Default value</label>' +
            '<input class="answer slider" type="text" name="' + inner_address + '[answers_attributes][2][content]" ' +
            'id="' + id + '2" />' +
            '<a id="' + id + '0_remove" class="remove_item" href="#">Remove</a></h5>');

    }
    return cont;
}
$(document).on('change', '.question_type', function () {
    $(this).parent().find('.answers').replaceWith('<div class="answers"><ol></ol></div>');
});


$(document).on('click', '.remove_item', function () {
    $(this).parent().
    remove()  //with SlideUp testing with Capybara not works
    //slideUp("normal", function () {       $(this).remove();    });

});

$(document).on('ajax:success', '.remove_item', function () {
    $(this).parent().next().remove();
    $(this).parent().slideUp("normal", function () {
        $(this).remove();
    });
});