package com.gootdate.cs.websocket;

import java.util.ArrayList;

import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;



public class WebSocketHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	//연결됐을때 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		 sessionList.add(session);
	        System.out.println(session.getPrincipal().getName()+"{} 연결됨");
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		 System.out.println(("{}로 부터 {} 받음"+ session.getPrincipal().getName()+ message.getPayload()));
	        for (WebSocketSession sess : sessionList) {
	          sess.sendMessage(new TextMessage(session.getPrincipal().getName()+ ":" + message.getPayload()));
	        }
	}

	// 클라이언트 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
        System.out.println((" 연결 끊김"+ session.getPrincipal().getName()));
	}

}
