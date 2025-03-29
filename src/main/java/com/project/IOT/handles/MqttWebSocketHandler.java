//package com.project.IOT.handles;
//
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import java.io.IOException;
//import java.util.concurrent.CopyOnWriteArrayList;
//
//public class MqttWebSocketHandler extends TextWebSocketHandler {
//
//    // Danh sách các session để gửi message tới tất cả client
//    private final CopyOnWriteArrayList<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
//
//    @Override
//    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        sessions.add(session); // Thêm client mới vào danh sách
//    }
//
//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        sessions.remove(session); // Xóa client khi ngắt kết nối
//    }
//
//    // Gửi message tới tất cả client
//    public void sendMessageToAll(String message) {
//        for (WebSocketSession session : sessions) {
//            try {
//                if (session.isOpen()) {
//                    session.sendMessage(new TextMessage(message));
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//    }
//}