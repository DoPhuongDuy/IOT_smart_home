import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/topic_dto.dart';

class UnsubscribeTopicScreen extends StatefulWidget {
  @override
  _UnsubscribeTopicScreenState createState() => _UnsubscribeTopicScreenState();
}

class _UnsubscribeTopicScreenState extends State<UnsubscribeTopicScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pathController = TextEditingController();
  bool subscribe = false;

  Future<void> _unsubscribeToTopic() async {
    final topicDTO = TopicDTO(
      id: int.parse(idController.text),
      name: nameController.text,
      path: pathController.text,
      subscribe: subscribe,
      latest_data: "",
    );
    try {
      final response = await apiService.unsubscribeToTopic(topicDTO);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unsubscribe from Topic")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: "ID"),
              keyboardType: TextInputType.number,
            ),
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: pathController, decoration: InputDecoration(labelText: "Path")),
            CheckboxListTile(
              title: Text("Subscribe"),
              value: subscribe,
              onChanged: (value) {
                setState(() {
                  subscribe = value ?? false;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _unsubscribeToTopic, child: Text("Unsubscribe")),
          ],
        ),
      ),
    );
  }
}