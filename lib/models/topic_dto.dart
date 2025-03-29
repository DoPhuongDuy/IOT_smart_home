class TopicDTO {
  final int id;
  final String name;
  final String path;
  final bool subscribe;
  final String latest_data;

  TopicDTO({
    required this.id,
    required this.name,
    required this.path,
    required this.subscribe,
    required this.latest_data,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'subscribe': subscribe,
      'latest_data': latest_data,
    };
  }

  factory TopicDTO.fromJson(Map<String, dynamic> json) {
    return TopicDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      path: json['path'] as String,
      subscribe: json['subscribe'] as bool,
      latest_data: json['latest_data'] as String,
    );
  }
}