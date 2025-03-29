package com.project.IOT.Mapper;

import com.project.IOT.dtos.TopicDTO;
import com.project.IOT.entities.Topic;
import org.springframework.stereotype.Component;

@Component
public class TopicMapper {
    public TopicDTO toDTO(Topic topic) {
        return TopicDTO.builder()
                .name(topic.getName())
                .path(topic.getPath())
                .subscribe(topic.getSubscribe())
                .build();
    }

    public Topic toEntity(TopicDTO topicDTO) {
        return Topic.builder()
                .name(topicDTO.getName())
                .path(topicDTO.getPath())
                .subscribe(topicDTO.getSubscribe())
                .build();
    }
}
