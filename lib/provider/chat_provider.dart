import 'package:flutter/material.dart';

class Patient {
  final String id;
  final String name;
  final int age;
  final String condition;

  Patient(
      {required this.id,
      required this.name,
      required this.age,
      required this.condition});
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String? sender;

  final DateTime time;
  ChatMessage(
      {required this.text,
      required this.isSentByMe,
      required this.time,
      this.sender});
}

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
        sender: 'Alice',
        text: 'Hi there!',
        time: DateTime.now().subtract(const Duration(minutes: 2)),
        isSentByMe: true),
    ChatMessage(
        sender: 'Bob',
        text: 'Hello!',
        time: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    ChatMessage(
        sender: 'Alice',
        text: 'How are you?',
        time: DateTime.now(),
        isSentByMe: false),
    ChatMessage(
        sender: 'Bob',
        text: 'I am good, thanks! And you?',
        time: DateTime.now().add(const Duration(minutes: 1)),
        isSentByMe: false),
    ChatMessage(
        sender: 'Alice',
        text: 'Doing well, just working on a Flutter project.',
        time: DateTime.now().add(const Duration(minutes: 2)),
        isSentByMe: false),
  ];
  String _currentMessage = '';
  final TextEditingController _tetChat = TextEditingController();
  TextEditingController get tetChat => _tetChat;
  List<ChatMessage> get messages => _messages;
  String get currentMessage => _currentMessage;

  void updateCurrentMessage(String message) {
    _currentMessage = message;
    notifyListeners();
  }

  void sendMessage() {
    if (tetChat.text.isNotEmpty) {
      _messages.add(ChatMessage(
          text: tetChat.text, isSentByMe: true, time: DateTime.now()));
      tetChat.text = '';
      notifyListeners();
    }
  }

  void receiveMessage(String message) {
    _messages.add(
        ChatMessage(text: message, isSentByMe: false, time: DateTime.now()));
    notifyListeners();
  }

// patients list
  final List<Patient> _patients = [
    Patient(id: '1', name: 'John Doe', age: 45, condition: 'Hypertension'),
    Patient(id: '2', name: 'Jane Smith', age: 30, condition: 'Diabetes'),
    Patient(id: '3', name: 'Michael Johnson', age: 55, condition: 'Asthma'),
    Patient(id: '4', name: 'Emily Davis', age: 25, condition: 'Anemia'),
    Patient(id: '5', name: 'Chris Brown', age: 40, condition: 'Obesity'),
    Patient(id: '6', name: 'David Wilson', age: 50, condition: 'Chronic Pain'),
    Patient(id: '7', name: 'Sarah Miller', age: 35, condition: 'COPD'),
    Patient(id: '8', name: 'James Anderson', age: 60, condition: 'Cancer'),
    Patient(id: '9', name: 'Sophia Martinez', age: 29, condition: 'Migraine'),
    Patient(id: '10', name: 'Liam Taylor', age: 38, condition: 'Arthritis'),
    Patient(id: '11', name: 'Olivia Moore', age: 32, condition: 'Anxiety'),
    Patient(id: '12', name: 'Noah Thomas', age: 42, condition: 'Heart Disease'),
    Patient(id: '13', name: 'Emma White', age: 27, condition: 'Depression'),
    Patient(id: '14', name: 'Isabella Harris', age: 36, condition: 'Epilepsy'),
    Patient(
        id: '15', name: 'William Martin', age: 55, condition: 'Hypertension'),
    Patient(
        id: '16', name: 'Mia Thompson', age: 22, condition: 'Thyroid Issues'),
    Patient(id: '17', name: 'Lucas Garcia', age: 48, condition: 'Asthma'),
    Patient(id: '18', name: 'Amelia Clark', age: 33, condition: 'Diabetes'),
    Patient(
        id: '19', name: 'Benjamin Lewis', age: 44, condition: 'Heart Disease'),
    Patient(
        id: '20', name: 'Charlotte Walker', age: 28, condition: 'Osteoporosis'),
  ];

  List<Patient> get patients => _patients;
}
