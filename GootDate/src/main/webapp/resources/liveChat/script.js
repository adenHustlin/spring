
let audio = document.getElementById('audio')

var ws;
var messages = document.getElementById("message");
//페이지열리지마자 웹소켓객체생성
$(function() {
	$messages.mCustomScrollbar();
	console.log($("#sessionId").val())
	if (ws !== undefined && ws.readyState !== WebSocket.CLOSED) {

		console.log("session already exists")
		return;
	}

	//웹소켓 객체 만드는 코드
	/*ws = new WebSocket('ws://localhost:8081/websocket');*/
	ws = new WebSocket('ws://3.34.86.169:8080/websocket');
	console.log(ws)
	ws.onopen = function(event) {
		console.log("connected")
		ws.send($("#sessionId").val() + "," + "connected" + "," + " has been connected");


	};
	ws.onmessage = function(event) {
		ProcessMessage(event);
	};
	ws.onclose = function(event) {
		if (event.data === undefined) return;
		console.log("websocket closed")
	}

})



//send 버튼 누르면 메시지 소켓에 전송 화면에 뽑는건 다시 받아온거를 뽑는다
$('.message-submit').click(function() {

	if ($.trim($(".message-input").val()) == '') {
		return false;
	}
	let request;
	let userid = $("#sessionId").val()
	let purpose = "chat"
	let message = $(".message-input").val();
	request = userid + "," + purpose + "," + message;

	ws.send(request);
	$(".message-input").val('')
	request = "";


});
//페이지 나가거나 바꾸기전 소캣객체 닫기
$(window).on("beforeunload", function() {
	ws.send($("#sessionId").val() + "," + "disconnected" + "," + " has been disconnected");
	ws.close();
})
//chat room css part
var $messages = $('.messages-content'),
	d, h, m,
	i = 0;



function updateScrollbar() {
	$messages.mCustomScrollbar("update").mCustomScrollbar('scrollTo', 'bottom', {
		scrollInertia: 10,
		timeout: 0
	});
}

function setDate() {
	d = new Date()
	if (m != d.getMinutes()) {
		m = d.getMinutes();
		$('<div class="timestamp">' + d.getHours() + ':' + m + '</div>').appendTo($('.message').last());
		$('<div class="checkmark-sent-delivered">&check;</div>').appendTo($('.message:last'));
		$('<div class="checkmark-read">&check;</div>').appendTo($('.message:last'));
	}
}

//웹소켓에서 받아온 메시지 출력
function ProcessMessage(event) {
	let str = event.data.split(",");
	let userid = str[0];
	let purpose = str[1]
	let message = str[2];


	if (purpose == "connected") {
		toastr.info(userid + "  " + message);


	} else if (purpose == "disconnected") {
		toastr.error(userid + "  " + message);

	} else if (purpose == "chat") {
		if ($('.mCSB_container').length>0) {
			if (userid == $("#sessionId").val()) {
				$('<div class="message message-personal">' + message + '</div>').appendTo($('.mCSB_container')).addClass('new');
				setDate();
				updateScrollbar();
			} else {
				audio.play();
				$('<div class="message new"><figure class="avatar"><img src="http://askavenue.com/img/17.jpg" /></figure>' + message + '</div>').appendTo($('.mCSB_container')).addClass('new');
				setDate();
				updateScrollbar();
			}
		}
		else{
			toastr.info(userid + "  sent new message");
		}
	} else if (purpose == "notification") {
		toastr.info(userid + "  " + message);
	}

}


/*var Fake = [
	'Hi there, I\'m Jesse and you?',
	'Nice to meet you',
	'How are you?',
	'Not too bad, thanks',
	'What do you do?',
	'That\'s awesome',
	'Codepen is a nice place to stay',
	'I think you\'re a nice person',
	'Why do you think that?',
	'Can you explain?',
	'Anyway I\'ve gotta go now',
	'It was a pleasure chat with you',
	'Time to make a new codepen',
	'Bye',
	':)'
]

function firstMessage() {

	updateScrollbar();

	setTimeout(function() {
		$('.message.loading').remove();
		$('<div class="message new"><figure class="avatar"><img src="http://askavenue.com/img/17.jpg" /></figure>' + Fake[i] + '</div>').appendTo($('.mCSB_container')).addClass('new');
		setDate();
		updateScrollbar();
		i++;
	}, 1000 + (Math.random() * 20) * 100);

}*/

$('.button').click(function() {
	$('.menu .items span').toggleClass('active');
	$('.menu .button').toggleClass('active');
});


