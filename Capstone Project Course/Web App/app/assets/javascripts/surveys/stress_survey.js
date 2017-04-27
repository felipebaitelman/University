var stress_survey = (function() {
    $("#STquestion2").hide();
    $("#STquestion3").hide();
    $("#STquestion4").hide();
    $("#STquestion5").hide();
    $("#STquestion6").hide();
    $("#STquestion7").hide();
    $("#STsubmit_b").hide();
    $(".titleshow").hide();

    var current = 1;
    var next = 2;
    var total = 7;

    $('#next_questionST').click(function (){
        $('#STquestion' + current).hide(0);
        $('#STquestion' + next).show(0);

        if(current < total -1) {
            current++;
            next++;
        }
        else {
            $('#next_questionST').hide(0)
            $('#STsubmit_b').show(0);
        }
    })


    $("#STsubmit_b").click(function () {
        $(".titlehide").hide(0);
        $(".titleshow").show(0);
        $('#STquestion' + total).hide(0);
        $("#STsubmit_b").hide(0);
        $('#stress_results').show(0);
    });
});

$(document).on('turbolinks:load', stress_survey);
