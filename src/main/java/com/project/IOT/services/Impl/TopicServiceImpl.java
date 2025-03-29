package com.project.IOT.services.Impl;

import com.project.IOT.Mapper.TopicMapper;
import com.project.IOT.dtos.TopicDTO;
import com.project.IOT.entities.Topic;
import com.project.IOT.responsitories.TopicRepository;
import com.project.IOT.services.TopicService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TopicServiceImpl implements TopicService {

    private final MqttClient mqttClient;
    private final TopicRepository topicRepository;
    private final TopicMapper topicMapper;

    @Override
    public String subscribeToTopic(TopicDTO topicDTO) throws MqttException {
        Optional<Topic> existingTopic = topicRepository.findByPath(topicDTO.getPath());
        Topic topic;
        if (existingTopic.isPresent()) {
            topic = existingTopic.get();
            topic.setSubscribe(true);
        } else {
            topic = topicMapper.toEntity(topicDTO);
            topic.setSubscribe(true);
        }
        topicRepository.save(topic);
        mqttClient.subscribe(topicDTO.getPath());

        return "Subscribed to topic: " + topicDTO.getPath();
    }

    @Override
    public String unsubscribeTopic(TopicDTO topicDTO) throws MqttException {
        Topic existingTopic = topicRepository.findByPath(topicDTO.getPath())
                .orElseThrow(() -> new EntityNotFoundException("Topic not found with path: " + topicDTO.getPath()));
        if (existingTopic != null) {
            existingTopic.setSubscribe(false);
            topicRepository.save(existingTopic);
            mqttClient.unsubscribe(topicDTO.getPath());
        }
        return "Unsubscribed to topic: " + topicDTO.getPath();
    }
}
