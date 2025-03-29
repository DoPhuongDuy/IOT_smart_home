import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mqtt_dto.dart';
import '../models/topic_dto.dart';
import '../api/api_endpoint.dart';

class ApiService {
  Future<List<TopicDTO>> getAllData() async {
    final response = await http.get(Uri.parse(ApiEndpoint.getAllData));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TopicDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MqttDTO> addData(MqttDTO mqttDTO) async {
    final response = await http.post(
      Uri.parse(ApiEndpoint.addData),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mqttDTO.toJson()),
    );
    if (response.statusCode == 201) {
      return MqttDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<String> controlLed(MqttDTO mqttDTO) async {
    final response = await http.post(
      Uri.parse(ApiEndpoint.controlLed),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mqttDTO.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to control LED');
    }
  }

  Future<String> publishMessage(MqttDTO mqttDTO) async {
    final response = await http.post(
      Uri.parse(ApiEndpoint.publishMessage),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mqttDTO.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to publish message');
    }
  }

  Future<String> subscribeToTopic(TopicDTO topicDTO) async {
    final response = await http.post(
      Uri.parse(ApiEndpoint.subscribeToTopic),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(topicDTO.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to subscribe to topic');
    }
  }

  Future<String> unsubscribeToTopic(TopicDTO topicDTO) async {
    final response = await http.post(
      Uri.parse(ApiEndpoint.unsubscribeToTopic),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(topicDTO.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to unsubscribe from topic');
    }
  }
}