package com.codenator.action;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.codenator.Container.WebsocketSessionContainer;

@ServerEndpoint("/websocket")
public class Output {
    @OnOpen
    public void onOpen(Session session) {
    		System.out.println("Client is now connected...");
    }

    @OnMessage
    public void onMessage(String sessionId, Session session) {
        System.out.println("in output websocketSessionID:"+session.hashCode());
        WebsocketSessionContainer.webSocketSessions.put(sessionId,session);
        System.out.println(sessionId);
    }
    
    public void sendMessage(String message, Session session){
        try{
            session.getBasicRemote().sendText(message);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    
    @OnClose
    public void onClose(Session session) {
        System.out.println("Connection closed");
    }

    @OnError
    public void handleError(Throwable t){
        t.printStackTrace();
    }
    
}
