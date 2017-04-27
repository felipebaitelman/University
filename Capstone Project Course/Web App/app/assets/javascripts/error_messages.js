/**
 * Created by esteban on 17-11-16.
 */
var error_messages = (function() {
    $('#user_current_password').on('change_invalid', function(){
        var textfield = $this.get(0);
        textfield.setCustomValidity('');

        if(!textfield.validity.valid){
            textfield.setCustomValidity('Ingrese su contraseña actual');
        }
    })
});

$(document).on('turbolinks:load', error_messages);