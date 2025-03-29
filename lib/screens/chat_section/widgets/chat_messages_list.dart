import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/model/chat_section_models/message_data_model.dart';
import 'package:frappe_flutter_app/screens/chat_section/chat_screen.dart';
import 'package:frappe_flutter_app/screens/chat_section/widgets/message_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  final List<MessageData> messages;

  const ChatMessagesList({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        
        return MessageBubble(
          message: message,
          showTime: true,
        );
      },
    );
  }
}