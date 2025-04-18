package com.project.IOT.listener;

import com.project.IOT.Mapper.MqttMapper;
import com.project.IOT.Mapper.TopicMapper;
import com.project.IOT.dtos.MqttDTO;
import com.project.IOT.dtos.TopicDTO;
import com.project.IOT.entities.Mqtt;
import com.project.IOT.entities.Topic;
import com.project.IOT.responsitories.MqttResponsitory;
import com.project.IOT.responsitories.TopicRepository;
import com.project.IOT.services.MqttService;

import com.project.IOT.services.TopicService;
import jakarta.persistence.EntityNotFoundException;
import org.eclipse.paho.client.mqttv3.*;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public class MqttListener {
    private final MqttResponsitory mqttResponsitory;
    private final TopicRepository topicRepository;
    private final MqttMapper mqttMapper;
    private final TopicMapper topicMapper;
    private final SimpMessagingTemplate messagingTemplate;

    public MqttListener(MqttClient mqttClient, MqttResponsitory mqttResponsitory, TopicRepository topicRepository, MqttMapper mqttMapper, TopicMapper topicMapper, SimpMessagingTemplate messagingTemplate) throws MqttException {
        this.mqttResponsitory = mqttResponsitory;
        this.topicRepository = topicRepository;
        this.mqttMapper = mqttMapper;
        this.topicMapper = topicMapper;
        this.messagingTemplate = messagingTemplate;
        mqttClient.setCallback(new MqttCallback() {
            @Override
            public void connectionLost(Throwable cause) {
                System.out.println("MQTT Connection lost!");
            }

            @Override
            public void messageArrived(String topic, MqttMessage message) throws Exception {
                String payload = new String(message.getPayload());
                System.out.println("Received: " + payload);
                Topic existingTopic = topicRepository.findByPath(topic)
                        .orElseThrow(() -> new EntityNotFoundException("Topic not found with path: " + topic));
                existingTopic.setLatest_data(payload);
                MqttDTO mqttDTO = new MqttDTO(existingTopic.getId(),payload);
                topicRepository.save(existingTopic);
                Mqtt mqtt = mqttMapper.toEntity(mqttDTO, existingTopic);
                mqttResponsitory.save(mqtt);
                TopicDTO topicDTO = topicMapper.toDTO(existingTopic);
                topicDTO.setPath("NoData");
                topicDTO.setSubscribe(true);
                messagingTemplate.convertAndSend("/topic/mqtt", topicDTO);
            }

            @Override
            public void deliveryComplete(IMqttDeliveryToken token) {
                System.out.println("Message delivered!");
            }
        });
        List<Topic> topics = topicRepository.findAll();
        for (Topic topic : topics){
            if(topic.getSubscribe()){
                mqttClient.subscribe(topic.getPath());
            }
        }
    }
}
