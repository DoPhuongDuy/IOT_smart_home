class ApiEndpoint {
  static const String baseUrl = 'http://localhost:8080'; // Thay bằng URL thực tế
  static const String wsUrl = 'ws://localhost:8080/ws';
  static const String getAllData = '$baseUrl/api/topic/getAll';
  static const String addData = '$baseUrl/api/mqtt/addData';
  static const String controlLed = '$baseUrl/api/mqtt/controlLed';
  static const String publishMessage = '$baseUrl/api/mqtt/publishMessage';
  static const String subscribeToTopic = '$baseUrl/api/topic/subscribeToTopic';
  static const String unsubscribeToTopic = '$baseUrl/api/topic/unsubscribeToTopic';
}