import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../models/topic_dto.dart';
import '../services/api_service.dart';
import 'dart:convert';

class GetAllScreen extends StatefulWidget {
  @override
  _GetAllScreenState createState() => _GetAllScreenState();
}

class _GetAllScreenState extends State<GetAllScreen> {
  final ApiService apiService = ApiService();
  List<TopicDTO> dataList = [];
  late StompClient stompClient;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _connectStomp();
  }

  Future<void> _fetchData() async {
    try {
      final data = await apiService.getAllData();
      setState(() {
        dataList = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _connectStomp() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws/websocket',
        onConnect: (StompFrame frame) {
          print("Connected to WebSocket!");
          stompClient.subscribe(
            destination: '/topic/mqtt',
            callback: (StompFrame frame) {
              if (frame.body != null) {
                final Map<String, dynamic> updatedTopic = json.decode(frame.body!);
                setState(() {
                  int index = dataList.indexWhere((topic) => topic.id == updatedTopic['id']);
                  if (index != -1) {
                    dataList[index] = TopicDTO.fromJson(updatedTopic);
                  } else {
                    dataList.add(TopicDTO.fromJson(updatedTopic));
                  }
                });
              }
            },
          );
        },
        onWebSocketError: (dynamic error) => print('WebSocket error: $error'),
      ),
    );
    stompClient.activate();
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get All Data")),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Name: ${dataList[index].name}"),
            subtitle: Text("Message: ${dataList[index].latest_data}"),
          );
        },
      ),
    );
  }
}
