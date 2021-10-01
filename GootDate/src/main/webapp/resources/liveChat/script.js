
let audio=document.getElementById('audio')

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
		insertToast(event)
		console.log(event)		
		if (event.data === undefined){return};			
	};
	ws.onmessage = function(event) {
		/*writeResponse(event.data);*/
		insertMessage(event);
	};
	ws.onclose = function(event) {
		console.log("websocket closed")
		if (event.data === undefined) return;	
		insertMessage(event)
	}

})
//alert

function insertToast(){
	if(event.type=="open"){
	toastr.success("you are connected to web socket");
	}
	if(event.data){
		
	}
}


//send 버튼 누르면 메시지 소켓에 전송 화면에 뽑는건 다시 받아온거를 뽑는다
$('.message-submit').click(function() {
		
	let text = $(".message-input").val();
	$(".message-input").val('')
	
	if ($.trim(text) == '') {
		return false;
	}
	ws.send(text);
	text = "";


});
//페이지 나가거나 바꾸기전 소캣객체 닫기
$(window).on("beforeunload", function() {
	ws.close();
})

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
function insertMessage(event) {
	if(event=="open"){
		$('<div class="message">' + msg + '</div>').appendTo($('.mCSB_container')).addClass('new');
		return
	}else if(event=="close"){
		return
	}
	let msg = event.data.split(":")[1];
	let Id=event.data.split(":")[0];
	
	if(Id==$("#sessionId").val()){
		$('<div class="message message-personal">' + msg + '</div>').appendTo($('.mCSB_container')).addClass('new');
		setDate();
		updateScrollbar();
	}else{
		audio.play();
		$('<div class="message new"><figure class="avatar"><img src="http://askavenue.com/img/17.jpg" /></figure>' + msg + '</div>').appendTo($('.mCSB_container')).addClass('new');
		setDate();
		updateScrollbar();
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


