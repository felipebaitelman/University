var nature = (function() {
    $('#nature1').on("submit",function() {
        alert ("Subiendo Video");
    });
    $( ".flex-next" ).trigger( "click" );
    $( ".flex-prev" ).trigger( "click" );
});

$(document).on('turbolinks:load', nature);
