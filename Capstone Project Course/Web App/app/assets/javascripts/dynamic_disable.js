var dynamic_disable = (function() {
    $("#dropdown_user").change(function() {
        if ($("#dropdown_user option:selected").text() === "Funcionario") {
            //$("#user_program").prop("disabled", "disabled");
            $("#student_field2").prop("disabled", true);
        }
        else {
            //$("#user_program").prop("disabled", false);
            $("#student_field2").prop("disabled", false);
        }
    })

    if ($("#dropdown_user option:selected").text() === "Funcionario") {
        //$("#user_program").prop("disabled", "disabled");
        $("#student_field2").prop("disabled", true);
    }
    else {
        //$("#user_program").prop("disabled", false);
        $("#student_field2").prop("disabled", false);
    }

});

$(document).on('turbolinks:load', dynamic_disable);

