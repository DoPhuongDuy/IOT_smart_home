import 'package:flutter/material.dart';
import 'screens/get_all_screen.dart';
import 'screens/add_data_screen.dart';
import 'screens/control_led_screen.dart';
import 'screens/publish_message_screen.dart';
import 'screens/subscribe_topic_screen.dart';
import 'screens/unsubscribe_topic_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQTT API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    ActiveDevicesScreen(),
    AddDataScreen(),
    ControlLedScreen(),
    PublishMessageScreen(),
    SubscribeTopicScreen(),
    UnsubscribeTopicScreen(),
  ];

  final List<String> _screenNames = [
    "Get All Data",
    "Add Data",
    "Control LED",
    "Publish Message",
    "Subscribe to Topic",
    "Unsubscribe from Topic",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_screenNames[_selectedIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'MQTT API Demo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ...List.generate(_screenNames.length, (index) {
              return ListTile(
                title: Text(_screenNames[index]),
                selected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
