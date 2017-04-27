var infographic =(function() {
    $('#Concéntrate').on("click",function() {
        $.ajax({
            type: 'POST',
            url: '/logs/create_conc',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
        });
    });
    $('#Desactívate').on("click",function() {
        $.ajax({
            type: 'POST',
            url: '/logs/create_des',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
        });    });
    $('#Empodérate').on("click",function() {
        $.ajax({
            type: 'POST',
            url: '/logs/create_emp',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
        });
    });
    bootstrap_alert = function() {};
    bootstrap_alert.warning = function(message) {
        $('#alert_placeholder').html('<div class="alert alert-success fade in">' +
            '<a class="close" data-dismiss="alert">×</a><span>'+message+'</span></div>');
        $("#alert_placeholder").fadeTo(2000, 500).slideUp(500, function(){
            $("#alert_placeholder").slideUp(500);
        });
    };

    $('#order').on("click",function() {
        var data = {};
        var correct = true;
        for(var i = 0; i<image_count.dataset.count; i++){
            if(correct){
                for(var j = 0; j<image_count.dataset.count; j++){
                    if(j!=i){
                        if(eval("Order"+i).value == eval("Order"+j).value){
                            alert("No se puede actualizar: Imagenes con el mismo orden");
                            correct = false;
                            break;
                        }
                    }
                }
            }
            data[eval("Image"+i).dataset.image_id] = {order: eval("Order"+i).value,
                description: eval("description"+i).value}
        }
        data["ID"] = infographic_id.dataset.id;
        if (correct) {
            $.ajax({
                type: 'POST',
                url: '/infographics/order',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
                data: data,
                dataType: 'json',
                success: bootstrap_alert.warning('Contenido Actualizado Corrctamente')
            });
        }
    });
    $('#form1').on("submit",function() {
        alert ("Subiendo imagenes");
    });
});
$(document).on('turbolinks:load', infographic);


