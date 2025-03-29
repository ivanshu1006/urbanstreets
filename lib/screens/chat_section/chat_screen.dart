import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/model/chat_section_models/message_data_model.dart';
import 'package:frappe_flutter_app/screens/chat_section/widgets/chat_messages_list.dart';
import 'package:frappe_flutter_app/screens/chat_section/widgets/message_bubble.dart';
import 'package:frappe_flutter_app/screens/chat_section/widgets/message_input.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  final String contactName;

  const ChatScreen({
    super.key,
    required this.contactName,
  });

  @override
  Widget build(BuildContext context) {
    // Sample messages for demonstration
    final List<MessageData> messages = [
      MessageData(
        text: "Hey, Jane. How are you doing today. I hope you are having a great day.",
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      MessageData(
        text: "Hey, Jane. How are you doing today. I hope you are having a great day.",
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        status: MessageStatus.seen,
      ),
      MessageData(
        imageUrl: "https://example.com/cinque-terre.jpg",
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        status: MessageStatus.seen,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          contactName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat messages area
            Expanded(
              child: ChatMessagesList(messages: messages),
            ),
            // Message input area
            const MessageInput(),
          ],
        ),
      ),
    );
  }
}




