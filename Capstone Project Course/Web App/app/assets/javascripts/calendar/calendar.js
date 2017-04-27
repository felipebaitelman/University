var calendar = (function() {
    $(function () {
        $('#datetimepicker1').datetimepicker({
            format: 'LT'
        });
        $('#datetimepicker2').datetimepicker({
            format: 'LT'
        });
        $('#datetimepicker3').datetimepicker({
            
        });
        $('#datetimepicker4').datetimepicker({
            
        });
    });

    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
        // put your options and callbacks here
        events: '/events.json',
        
        events: function(start, end, timezone, callback) {
                // Load Standard Events For Employee
                
                    $.ajax({
                        url: '/api/v1/calendar/agenda_events',
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
                                    day: $(this).attr('dia'),
                                    professor: $(this).attr('host'),
                                    campus: $(this).attr('campus'),
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
        //views: {
        //    agendaWeek: {
        //    eventLimit: 6 // adjust to 6 only for agendaWeek/agendaDay
        //    }
        //},   
        weekends: false,// will hide Saturdays and Sundays
        height: 810,
        defaultView: 'agendaWeek',
        
        listDayAltFormat: false, 

        minTime: '08:30:00',
        maxTime: '19:00:00',
        slotLabelFormat:"HH:mm",
        columnFormat: "dddd",
        allDaySlot: false,
        header: {
            left: '',
            center: '',
            right: ''
        },
        eventRender: function (event, element) {
            element.attr('href', 'javascript:void(0);');
            element.click(function() {
                $("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
                $("#endTime").html(moment(event.end).format('MMM Do h:mm A'));
                $("#day").html(event.day);
                $("#professor").html(event.professor);
                $("#campus").html(event.campus);
                $("#class").html(event.location);
                
                $("#totalcap").html(event.total_capacity);
                $("#eventContent").dialog({ modal: true, title: event.title, width:350});
                $('#cancel').unbind('click').bind('click', function () {    
                    $.ajax({
                        url: "/api/v1/calendar/big_cancel",

                        type: "POST",
                        data: JSON.stringify({ 'id-event': event.id}),
                        dataType: "json",
                        traditional: true,
                        contentType: "application/json; charset=utf-8",
                        
                        success: function (data) {
                            if (data.canceled == true) {
                                alert("La hora fue cancelada");
                                $('#calendar').fullCalendar( 'refetchEvents' );
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
            });
        }
    });
    $('#calendar').fullCalendar('gotoDate', gon.date);
});
$(document).on('turbolinks:load', calendar);
