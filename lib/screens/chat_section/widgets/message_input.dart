import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () {},
            color: Colors.grey[600],
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () {},
            color: Colors.grey[600],
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}