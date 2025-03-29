import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/mqtt_dto.dart';

class ControlLedScreen extends StatefulWidget {
  @override
  _ControlLedScreenState createState() => _ControlLedScreenState();
}

class _ControlLedScreenState extends State<ControlLedScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController idTopicController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  Future<void> _controlLed() async {
    final mqttDTO = MqttDTO(
      idTopic: int.parse(idTopicController.text),
      value: valueController.text,
    );
    try {
      final response = await apiService.controlLed(mqttDTO);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Control LED")),
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
            ElevatedButton(onPressed: _controlLed, child: Text("Control LED")),
          ],
        ),
      ),
    );
  }
}