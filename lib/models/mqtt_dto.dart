class MqttDTO {
  final int idTopic;
  final String value;

  MqttDTO({
    required this.idTopic,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'idTopic': idTopic,
      'value': value,
    };
  }

  factory MqttDTO.fromJson(Map<String, dynamic> json) {
    return MqttDTO(
      idTopic: json['idTopic'] as int,
      value: json['value'] as String,
    );
  }
}