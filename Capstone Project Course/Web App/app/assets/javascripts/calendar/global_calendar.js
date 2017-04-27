var global_calendar = (function() {
    $('#globalcalendar').fullCalendar({
        // put your options and callbacks here
       
        
        events: function(start, end, timezone, callback) {
                // Load Standard Events For Employee
                
                    $.ajax({
                        url: '/api/v1/calendar/global_events',
                        type: 'GET',
                        //headers : { 'email': current_user },
                        
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
                                    
                                    professor: $(this).attr('host'),
                                    campus: $(this).attr('faculty'),
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
        weekends: false,// will hide Saturdays and Sundays
        height: 810,
        columnFormat: "dddd",
        allDaySlot: false,
        header: {
            left: 'month, agendaWeek',
            center: 'title',
            right: 'today prev, next'
        },
        eventRender: function (event, element) {
            element.attr('href', 'javascript:void(0);');
            element.click(function() {
                $("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
                $("#endTime").html(moment(event.end).format('MMM Do h:mm A'));
                $("#professor").html(event.professor);
                $("#campus").html(event.campus);
                $("#class").html(event.location);
                $("#availablecap").html(event.remaining_capacity);
                $("#totalcap").html(event.total_capacity);
                $("#eventContent").dialog({ modal: true, title: event.title, width:350});
                $('#cancel').unbind('click').bind('click', function () {    
                    $.ajax({
                        url: "/api/v1/calendar/admin_cancel",

                        type: "POST",
                        data: JSON.stringify({ 'id-event': event.id}),
                        dataType: "json",
                        traditional: true,
                        contentType: "application/json; charset=utf-8",
                        
                        success: function (data) {
                            if (data.canceled == true) {
                                alert("La hora fue cancelada");
                                $('#globalcalendar').fullCalendar( 'refetchEvents' );
                                $("#eventContent").dialog('close');
                            } else {
                                if(data.canceled == false){
                                    alert("Hubo un error al cancelar la hora");
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
                    
                });
                $('#edit').unbind('click').bind('click', function () {
                    //redirect_to edit_event_date_path(event_date)
                    window.location.href = '/event_dates/' + String(event.id ) + '/edit';
                });
            });
        }
    })
});

$(document).on('turbolinks:load', global_calendar);
