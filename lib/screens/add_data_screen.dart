import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/mqtt_dto.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController idTopicController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  Future<void> _addData() async {
    final mqttDTO = MqttDTO(
      idTopic: int.parse(idTopicController.text),
      value: valueController.text,
    );
    try {
      await apiService.addData(mqttDTO);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data added successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Data")),
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
            ElevatedButton(onPressed: _addData, child: Text("Add Data")),
          ],
        ),
      ),
    );
  }
}