package com.project.IOT.services.Impl;

import com.project.IOT.Mapper.MqttMapper;
import com.project.IOT.dtos.MqttDTO;
import com.project.IOT.entities.Mqtt;
import com.project.IOT.entities.Topic;
import com.project.IOT.responsitories.MqttResponsitory;
import com.project.IOT.responsitories.TopicRepository;
import com.project.IOT.services.MqttService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MqttServiceImpl implements MqttService {

    private final MqttResponsitory mqttResponsitory;
    private final TopicRepository topicRepository;
    private final MqttMapper mqttMapper;
    private final MqttClient mqttClient;

    @Override
    public List<MqttDTO> getAllData() {
        List<Mqtt> mqtts = mqttResponsitory.findAll();
        List<MqttDTO> mqttDTOS = new ArrayList<>();
        for (Mqtt mqtt : mqtts) {
            mqttDTOS.add(mqttMapper.toDTO(mqtt));
        }
        return mqttDTOS;
    }

    @Override
    public MqttDTO addData(MqttDTO mqttDTO) {
        Topic topic = topicRepository.findById(mqttDTO.getIdTopic())
                .orElseThrow(() -> new EntityNotFoundException("Topic not found with id: " + mqttDTO.getIdTopic()));
        Mqtt mqtt = mqttMapper.toEntity(mqttDTO, topic);
        Mqtt savedMqtt = mqttResponsitory.save(mqtt);
        return mqttMapper.toDTO(savedMqtt);
    }

    @Override
    public void saveMessage(MqttDTO mqttDTO) {
        Topic topic = topicRepository.findById(mqttDTO.getIdTopic())
                .orElseThrow(() -> new EntityNotFoundException("Topic not found with id: " + mqttDTO.getIdTopic()));
        Mqtt mqtt = mqttMapper.toEntity(mqttDTO, topic);
        mqttResponsitory.save(mqtt);
    }

    @Override
    public String publishMessage(MqttDTO mqttDTO) throws MqttException {
        MqttMessage mqttMessage = new MqttMessage(mqttDTO.getValue().getBytes());
        mqttMessage.setQos(1);
        Topic existingTopic = topicRepository.findById(mqttDTO.getIdTopic())
                .orElseThrow(() -> new EntityNotFoundException("Topic not found with id: " + mqttDTO.getIdTopic()));
        mqttClient.publish(existingTopic.getPath() , mqttMessage);
        Mqtt mqtt = mqttMapper.toEntity(mqttDTO, existingTopic);
        mqttResponsitory.save(mqtt);
        return "Đã publish: " + mqttDTO.getValue() + " tới topic: " + mqttDTO.getIdTopic();
    }
}
