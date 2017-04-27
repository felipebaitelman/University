var current_user = "<%= @current_user %>";

function refetch_events_and_close_dialog() {
  $('#usercalendar').fullCalendar( 'refetchEvents' );
  $('.dialog:visible').dialog('destroy');
}


var user_calendar = (function() {
    
   
    
    
    $('#usercalendar').fullCalendar({
        // put your options and callbacks here
        //events: '/event_dates.json',
        events: function(start, end, timezone, callback) {
                // Load Standard Events For Employee
                
                    $.ajax({
                        url: '/api/v1/calendar/event_dates',
                        type: 'GET',
                        //headers : { 'email': current_user },
                        headers: { 'email': gon.current_user },
                        data: ({email: gon.current_user, event_type: gon.event_type, host: gon.host, campus: gon.campus, web_calendar: 'true'} ),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                       
                        
                        success: function (data) {

                            var events = [];
                            $(data).each(function() {
                                events.push({
                                    id: $(this).attr('id'),
                                    title: $(this).attr('title'),
                                    start: $(this).attr('start'),
                                    end: $(this).attr('end'),// will be parsed
                                    user_booked: $(this).attr('user_booked'),
                                    professor: $(this).attr('host'),
                                    campus2: $(this).attr('faculty'),
                                    location: $(this).attr('location'),
                                    remaining_capacity: $(this).attr('remaining_capacity'),
                                    total_capacity: $(this).attr('capacity')
                                });
                            });
                            callback(events);
                        },
                        error: function (data) {
                             alert('there was an error while fetching events!');
                            //alert(data);
                        }
                    });
                            },
                           //...(Additional Functions for other events)
             
       //events: {
       //    
       //    url: '/api/v1/calendar/event_dates',
       //    type: 'GET',
       //    //headers : { 'email': current_user },
       //    data: {
       //        email: gon.current_user,
       //        event_type: gon.event_type,// $('#event_type').find(":selected").val(),
       //        //campus: $('#campus').value,
       //        web_calendar: 'true'
       //    },
       //    error: function() {
       //        alert('there was an error while fetching events!');
       //    },
    
       //},
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
        buttonText: {
          today: 'Hoy',
          month: 'Mes',
          week: 'Semana',
          day: 'Día'
        },
        defaultView: 'listWeek',
        header: {
            left: '',
            center: 'title',
            right: 'today prev, next'
        },
        eventClick: function(event) {
            if (event.url) {
                return false;
            }
        },
        
        eventRender: function (event, element) {
            if(event.user_booked == true){ 
                element.find('.fc-list-item-title').prepend('<div class="booked">Reservado</div> ');
            }
            element.attr('href', 'javascript:void(0);');
            element.children('td').attr('href', 'javascript:void(0);');
            element.children('td').children('a').attr('href', 'javascript:void(0);');
            element.click(function() {
                $("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
                $("#endTime").html(moment(event.end).format('MMM Do h:mm A'));
                $("#professor").html(event.professor);
                
                $("#class").html(event.location);

                $("#faculty").html(event.campus2);
                $("#availablecap").html(event.remaining_capacity);
                $("#totalcap").html(event.total_capacity);

                $("#eventContent").dialog({ modal: true, title: event.title, width:350});
                if (event.user_booked == true){
                        //window.alert(event.id);
                        $('#book').text("Cancelar");
                }
                else {
                        $('#book').text("Reservar");
                }
                $('#book').unbind('click').bind('click', function () {
                    //window.alert(event.user_booked);
                    if (event.user_booked == true){
                        //window.alert(event.id);
                        $('#book').innerHTML = "Cancelar";
                        $.ajax({
                            url: "/api/v1/calendar/cancel_book",
                            headers: { 'email': gon.current_user },
                            type: "POST",
                            data: JSON.stringify({ 'id-event': event.id}),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                //window.alert(event.id)
                                if (data.canceled == true) {
                                    alert("Su hora sido cancelada");
                                    $('#usercalendar').fullCalendar( 'refetchEvents' );
                                    $("#eventContent").dialog('close');
                                } else {
                                    if(data.canceled == false){
                                        alert("La hora no pudo ser cancelada");
                                        $('#usercalendar').fullCalendar( 'refetchEvents' );
                                    }
                                    else {
                                        alert("Error occurs on the Database level!");
                                    }
                                }
                            },
                            error: function () {

                                alert("An error has occured!!!");
                            }
                        });
                    }
                    
                    else {
                        $('#book').innerHTML = "Reservar";
                        $.ajax({
                            url: "/api/v1/calendar/book",
                            headers: { 'email': gon.current_user },
                            type: "POST",
                            data: JSON.stringify({ 'id-event': event.id}),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
   
                                if (data.available == true) {
                                    alert("Su hora ha sido reservada");
                                    $('#usercalendar').fullCalendar( 'refetchEvents' );
                                    $("#eventContent").dialog('close');
                                } else {
                                    if(data.available == false){
                                        alert("La hora no esta disponible");
                                        $('#usercalendar').fullCalendar( 'refetchEvents' );
                                    }
                                    else {
                                        alert("Error occurs on the Database level!");
                                    }
                                }
                            },
                            error: function () {
                                window.alert(event.id)
                                alert("An error has occured!!!");
                            }
                        });
                    }
                });
            });
        }
    })
    
    
     $('[id$=usercalendar]').hide();
    $('[id$=backbutton]').hide();
    $("#event_type").change(function() {
            gon.event_type = $(this).val()
        });
    $("#campus").change(function() {
            gon.campus = $(this).val()
        });
    $("#teachers").change(function() {
            gon.host = $(this).val()
        }); 

    $('[id$=search]').click(function() {

        $('[id$=usercalendar]').show();
        $('[id$=backbutton]').show();
        $('[id$=searchfilters]').hide();
        $('[id$=search]').hide();
       });
      $('[id$=backbutton]').click(function() {
        $('[id$=usercalendar]').hide();
        $('[id$=backbutton]').hide();
        $('[id$=searchfilters]').show();
        $('[id$=search]').show();
       });
       
    if(gon.user_student){
        $('[id$=consejeria]').show();
        $('[id$=apoyo_grupal]').show();
        $('[id$=mindfulness]').show();
        $('[id$=yoga]').hide();
    }
    else{
        $('[id$=consejeria]').hide();
        $('[id$=apoyo_grupal]').hide();
        $('[id$=mindfulness]').hide();
        $('[id$=yoga]').show();
    }
    
});

$(document).on('turbolinks:load', user_calendar);

