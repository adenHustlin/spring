package com.gootdate.cs.websocket;

import java.util.ArrayList;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.plexus.component.annotations.Component;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Service
public class WebSocketHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	//연결됐을때 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		 sessionList.add(session);
		 
		 
		 
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			
//		String[] messageAr=message.getPayload().split(",");
//		String memberId=messageAr[0];
//		String purpose=messageAr[1];
//		String msg=messageAr[2];
			System.out.println(message.getPayload());
	        for (WebSocketSession sess : sessionList) {
	          sess.sendMessage(new TextMessage(message.getPayload()));
	        }
	
	}

	// 클라이언트 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
        System.out.println("disconnected");
	}
	

}
