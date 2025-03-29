package com.project.IOT.services;
import com.project.IOT.dtos.TopicDTO;
import org.eclipse.paho.client.mqttv3.MqttException;

public interface TopicService {
    String subscribeToTopic(TopicDTO topicDTO) throws MqttException;
    String unsubscribeTopic(TopicDTO topicDTO) throws MqttException;
}
