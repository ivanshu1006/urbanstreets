// Data model for chat messages
import 'package:frappe_flutter_app/screens/chat_section/chat_screen.dart';
import 'package:frappe_flutter_app/screens/chat_section/widgets/message_bubble.dart';

class MessageData {
  final String? text;
  final String? imageUrl;
  final bool isMe;
  final DateTime timestamp;
  final MessageStatus? status;

  MessageData({
    this.text,
    this.imageUrl,
    required this.isMe,
    required this.timestamp,
    this.status,
  });
}
