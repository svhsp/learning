import 'message.dart';

class Group {
  final String id;
  final String name;
  final List<Message> messages;
  Group({required this.id, required this.name, required this.messages});
}