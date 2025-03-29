import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/topic_dto.dart';

class SubscribeTopicScreen extends StatefulWidget {
  @override
  _SubscribeTopicScreenState createState() => _SubscribeTopicScreenState();
}

class _SubscribeTopicScreenState extends State<SubscribeTopicScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pathController = TextEditingController();
  bool subscribe = true;

  Future<void> _subscribeToTopic() async {
    final topicDTO = TopicDTO(
      id: int.parse(idController.text),
      name: nameController.text,
      path: pathController.text,
      subscribe: subscribe,
      latest_data: "",
    );
    try {
      final response = await apiService.subscribeToTopic(topicDTO);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subscribe to Topic")),
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
                  subscribe = value ?? true;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _subscribeToTopic, child: Text("Subscribe")),
          ],
        ),
      ),
    );
  }
}