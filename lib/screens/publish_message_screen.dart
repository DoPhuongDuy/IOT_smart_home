import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/mqtt_dto.dart';

class PublishMessageScreen extends StatefulWidget {
  @override
  _PublishMessageScreenState createState() => _PublishMessageScreenState();
}

class _PublishMessageScreenState extends State<PublishMessageScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController idTopicController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  Future<void> _publishMessage() async {
    final mqttDTO = MqttDTO(
      idTopic: int.parse(idTopicController.text),
      value: valueController.text,
    );
    try {
      final response = await apiService.publishMessage(mqttDTO);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Publish Message")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idTopicController,
              decoration: InputDecoration(labelText: "Topic ID"),
              keyboardType: TextInputType.number,
            ),
            TextField(controller: valueController, decoration: InputDecoration(labelText: "Value")),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _publishMessage, child: Text("Publish Message")),
          ],
        ),
      ),
    );
  }
}