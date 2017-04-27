var programs_user = (function() {

    'use strict';
    // -------------------------------------------------------------
    //   Smart Navigation
    // -------------------------------------------------------------
    (function () {
        var $frame  = $('#smart');
        var $slidee = $frame.children('ul').eq(0);
        var $wrap   = $frame.parent();
        // Call Sly on frame
        $frame.sly({
            itemNav: 'basic',
            smart: 1,
            activateOn: 'click',
            mouseDragging: 1,
            touchDragging: 1,
            releaseSwing: 1,
            startAt: 1,
            scrollBar: $wrap.find('.scrollbar'),
            scrollBy: 1,
            pagesBar: $wrap.find('.pages'),
            activatePageOn: 'click',
            speed: 300,
            elasticBounds: 1,
            easing: 'easeOutExpo',
            dragHandle: 1,
            dynamicHandle: 1,
            clickBar: 1,

            // Buttons
            forward: $wrap.find('.forward'),
            backward: $wrap.find('.backward'),
            prev: $wrap.find('.prev'),
            next: $wrap.find('.next'),
            prevPage: $wrap.find('.prevPage'),
            nextPage: $wrap.find('.nextPage')
        });
    }());

    var $response = $('.response');
    $response.hide();
});

var programs_user2 = (function() {

    'use strict';
    // -------------------------------------------------------------
    //   Smart Navigation
    // -------------------------------------------------------------
    (function () {
        var $frame2  = $('#smart-response');
        var $slidee2 = $frame2.children('ul').eq(0);
        var $wrap2   = $frame2.parent();
        $frame2.sly({
            itemNav: 'basic',
            smart: 1,
            activateOn: 'click',
            mouseDragging: 1,
            touchDragging: 1,
            releaseSwing: 1,
            startAt: 1,
            scrollBar: $wrap2.find('.scrollbar'),
            scrollBy: 1,
            pagesBar: $wrap2.find('.pages'),
            activatePageOn: 'null',
            speed: 300,
            elasticBounds: 1,
            easing: 'easeOutExpo',
            dragHandle: 1,
            dynamicHandle: 1,
            clickBar: 1,

            // Buttons
            forward: $wrap2.find('.forward'),
            backward: $wrap2.find('.backward'),
            prev: $wrap2.find('.prev'),
            next: $wrap2.find('.next'),
            prevPage: $wrap2.find('.prevPage'),
            nextPage: $wrap2.find('.nextPage')
        });
    }());
});

var response_window = (function(){
    var $items = $('.list-item');
    $items.on('click', function(){
        var $response = $('.response');
        $response.show();
        var $currentElement = $(this);
        var current_id = $currentElement.data('id');
        var data = {};
        for(var j = 0 ; j < $currentElement.data('sound_count');j++){
            var element =$('#Sound'+current_id + '-' + j);
            data[element.data('order')] = {name: element.data('name'),
                description: element.data('description'), duration: element.data('duration'),
                file: element.data('file')
            };
        }
        var audio = document.getElementById('barrita');
        audio.pause();
        audio.currentTime = 0;
        createResponseWindow(data, $currentElement);
    });

    var createResponseWindow = function(data, program) {
        count = program.data('sound_count');
        program_id = program.data('id');
        //bad practice but ...
        $('#current').data('program', program_id);
        $('#current').data('count', count);
        $('.items-response').empty();
        $('#wrap-response').show();

        var $items2 = $('.items-response');

        for(var i = 1; i< count+1 ; i++){
            var $newItem = document.createElement('li');
            $newItem.className = 'list_div'+i;
            $newItem.id = 'curr_div'+i;

            var $datavar = document.createElement('div');
            $($datavar).append(data[i]['name']);
            $datavar.style.display = "inline";
            $datavar.style.float = "left";
            $datavar.style.marginLeft = "10px";
            $datavar.style.top = "30%";
            $($newItem).append($datavar);

            var $playDiv = document.createElement('div');
            $playDiv.className = 'glyphicon glyphicon-play';
            $playDiv.id = 'play'+i;

            var $pauseDiv = document.createElement('div');
            $pauseDiv.className = 'glyphicon glyphicon-pause';
            $pauseDiv.id = 'pause'+i;
            $pauseDiv.style.visibility = "hidden";

            var $stopDiv = document.createElement('div');
            $stopDiv.className = 'glyphicon glyphicon-stop';
            $stopDiv.id = 'stop'+i;

            var $timestamp = document.createElement('text');
            $timestamp.id = 'idtimestamp'+i;
            $($timestamp).append("0");

            $stopDiv.style.visibility = "hidden";
            $playDiv.style.display = "inline";
            $playDiv.style.float = "right";
            $playDiv.style.right = "60%";
            $playDiv.style.top = "30%";
            $stopDiv.style.display = "inline";
            $stopDiv.style.float = "right";
            $stopDiv.style.right = "40%";
            $stopDiv.style.top = "30%";
            $pauseDiv.style.display = "inline";
            $pauseDiv.style.float = "right";
            $pauseDiv.style.right = "57%";
            $pauseDiv.style.top = "30%";
            $timestamp.style.display = "inline";
            $timestamp.style.float = "right";
            $timestamp.style.top = "30%";
            $timestamp.style.right = "30%";
            $timestamp.style.visibility = "hidden";

            $($newItem).append($playDiv);
            $($newItem).append($pauseDiv);
            $($newItem).append($stopDiv);
            $($newItem).append($timestamp);


            if(i > program.data('current_sound')){
                $playDiv.style.visibility = "hidden";
                $stopDiv.style.visibility = "hidden";
                $pauseDiv.style.visibility = "hidden";
                $timestamp.style.visibility = "hidden";
            }

            $('#smart-response').sly("add", $newItem);

            (function(){
                const tmp_i = i;
                const Xprogram_id = program_id;
                $($playDiv).on('click', function () {
                    var k = 1;
                    var $curr_div = document.getElementById('curr_div' + tmp_i);
                    for(var j = 1; j< count+1 ; j++){
                        if (j != tmp_i){
                            var $other_div = document.getElementById('curr_div'+j);
                            if($other_div.classList.contains('playing')){
                                k = 0;
                            }
                        }
                    }
                    if (k == 1) {
                        $('#current').data('current', tmp_i);
                        $curr_div.style.background = '#2F4F4F';
                        $curr_div.style.opacity = 1;
                        $($curr_div).addClass('playing');
                        var audio = document.getElementById('barrita');
                        var source = document.getElementById('barritasource');
                        source.src = (data[tmp_i]['file']);
                        if (audio.currentTime != 0) {
                            audio.play();
                        }
                        else {
                            audio.load();
                            audio.play();
                            $.ajax({
                                type: 'POST',
                                url: '/logs/create_program',
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                                },
                                data: {log: {media_type: 'Program', media_id: Xprogram_id, user_id: 1, date: 1}},
                                dataType: 'json',
                            });
                        }
                        var play = document.getElementById('play' + tmp_i);
                        play.style.visibility = "hidden";
                        var pause = document.getElementById('pause' + tmp_i);
                        pause.style.visibility = "visible";
                        var stop = document.getElementById('stop' + tmp_i);
                        stop.style.visibility = "visible";

                        var t = setInterval(function () {
                            if(audio.readyState > 0) {
                                var this_timestamp = document.getElementById('idtimestamp' + tmp_i);
                                this_timestamp.style.visibility = "visible";
                                updateClock(audio, tmp_i);
                                clearInterval(t);
                            }
                        }, 500);

                        var u = setInterval(function () {
                            updateClock(audio, tmp_i);
                        }, 500);


                        if(tmp_i == program.data('current_sound')){
                            $(audio).one("ended", function(){
                                unlock()
                            });
                        }
                        $(audio).one("ended", function(){
                            audio_finished(tmp_i);
                        });
                    }
                });
                $($pauseDiv).on('click', function () {
                    var audio = document.getElementById('barrita');
                    var source = document.getElementById('barritasource');
                    source.src = (data[tmp_i]['file']);
                    audio.pause();

                    var $play = document.getElementById('play'+tmp_i).style.visibility = "visible";
                    var $pause = document.getElementById('pause'+tmp_i).style.visibility = "hidden";
                    var $stop = document.getElementById('stop'+tmp_i).style.visibility = "visible";
                });

                $($stopDiv).on('click', function () {
                    var $curr_div = document.getElementById('curr_div' + tmp_i);
                    $curr_div.style.background = '#708090';
                    $curr_div.style.opacity = 0.5;
                    $($curr_div).removeClass('playing');
                    var audio = document.getElementById('barrita');
                    var source = document.getElementById('barritasource');
                    source.src = (data[tmp_i]['file']);
                    audio.pause();
                    audio.currentTime = 0;
                    var $play = document.getElementById('play'+tmp_i).style.visibility = "visible";
                    var $pause = document.getElementById('pause'+tmp_i).style.visibility = "hidden";
                    var $stop = document.getElementById('stop'+tmp_i).style.visibility = "hidden";
                    var $audiotime = document.getElementById('idtimestamp'+tmp_i).style.visibility = "hidden";
                })
            })();
        }
    };
});


$(document).on('turbolinks:load',response_window);
$(document).on('turbolinks:load',programs_user2);
$(document).on('turbolinks:load',programs_user);

function unlock() {
    $.ajax({
        type: 'POST',
        url: '/user_program',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        data:{
            'program': $('#current').data('program'),
            'current_sound': $('#current').data('current')
        },
        dataType: 'json',
        success: function(data){
            document.getElementById('play'+data['current_sound']).style.visibility = "visible";
            $('#program'+ data['program_id']).data('current_sound', data['current_sound']);
            alert (data['current_sound']);
        }
    });
}

function audio_finished(tmp_i) {
    var $curr_div = document.getElementById('curr_div' + tmp_i);
    $curr_div.style.background = '#708090';
    $curr_div.style.opacity = 0.5;
    $($curr_div).removeClass('playing');
    var audio = document.getElementById('barrita');
    audio.pause();
    audio.currentTime = 0;
    var $play = document.getElementById('play'+tmp_i).style.visibility = "visible";
    var $pause = document.getElementById('pause'+tmp_i).style.visibility = "hidden";
    var $stop = document.getElementById('stop'+tmp_i).style.visibility = "hidden";
}

function updateClock(audio, tmp_i) {
    var this_timestamp = document.getElementById('idtimestamp' + tmp_i);
    var total_timestamp = secondsToHms(Math.ceil(audio.duration));
    var curr_timestamp = secondsToHms(Math.ceil(audio.currentTime));
    this_timestamp.innerHTML = curr_timestamp +" "+"/"+" "+ total_timestamp;
}


function secondsToHms(d) {
    d = Number(d);
    var h = Math.floor(d / 3600);
    var m = Math.floor(d % 3600 / 60);
    var s = Math.floor(d % 3600 % 60);
    return ((h > 0 ? h + ":" + (m < 10 ? "0" : "") : "") + m + ":" + (s < 10 ? "0" : "") + s); }