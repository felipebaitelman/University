var stress_survey2 = (function() {

    $('#ST2question2').hide();
    $('#ST2question3').hide();
    $('#ST2question4').hide();
    $('#ST2question5').hide();
    $('#ST2question6').hide();
    $('#ST2question7').hide();
    $('#ST2question8').hide();
    $('#ST2question9').hide();
    $('#ST2question10').hide();
    $('#ST2question11').hide();
    $('#ST2question12').hide();
    $('#ST2question13').hide();
    $('#ST2question14').hide();
    $('#ST2submit_b').hide();
    $('.titleshow').hide();

    var current = 1;
    var next = 2;
    var total = 14;

    $('#next_questionST2').click(function (){
        $('#ST2question' + current).hide(0);
        $('#ST2question' + next).show(0);

        if(current < total -1) {
            current++;
            next++;
        }
        else {
            $('#next_questionST2').hide(0)
            $('#ST2submit_b').show(0);
        }
    })

    $('#ST2submit_b').click(function () {
        $('.titlehide').hide(0);
        $('.titleshow').show(0);
        $('#ST2question' + total).hide(0);
        $('#ST2submit_b').hide(0);
    });
});

$(document).on('turbolinks:load', stress_survey2);
