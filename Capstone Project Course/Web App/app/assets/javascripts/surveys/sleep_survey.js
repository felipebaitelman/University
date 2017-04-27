var sleep_survey = (function() {

    $('#SLquestion2').hide();
    $('#SLquestion3').hide();
    $('#SLquestion4').hide();
    $('#SLquestion5').hide();
    $('#SLquestion6').hide();
    $('#SLquestion7').hide();
    $('#SLquestion8').hide();
    $('#SLsubmit_b').hide();
    $('.titleshow').hide();

    var current = 1;
    var next = 2;
    var total = 8;

    $('#next_question').click(function (){

        $('#SLquestion' + current).hide(0);
        $('#SLquestion' + next).show(0);

        if(current < total -1) {
            current++;
            next++;
        }
        else {
            $('#next_question').hide(0)
            $('#SLsubmit_b').show(0);
        }
    })

    $('#SLsubmit_b').click(function () {
        $('.titlehide').hide(0);
        $('.titleshow').show(0);
        $('#SLquestion' + total).hide(0);
        $('#SLsubmit_b').hide(0);
        $('#sleep_results').show(0);
    });
});

$(document).on('turbolinks:load', sleep_survey);
