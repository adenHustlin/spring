package com.gootdate.cs.websocket;

import javax.inject.Inject;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
@Configuration
@EnableWebSocket
public class WebsocketConfig implements WebSocketConfigurer{
	@Inject
	WebSocketHandler webSocketHandler;
	

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		registry.addHandler(webSocketHandler,"/websocket").setAllowedOrigins("*")
				.addInterceptors(new HttpSessionHandshakeInterceptor());
	}
	


}
