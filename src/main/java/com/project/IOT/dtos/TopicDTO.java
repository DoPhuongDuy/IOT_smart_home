package com.project.IOT.dtos;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TopicDTO {
    private String name;
    private String path;
    private Boolean subscribe;
}
