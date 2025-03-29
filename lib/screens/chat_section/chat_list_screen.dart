import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for story/status circle users
    final List<User> storyUsers = List.generate(
      5,
      (index) => User(
        id: index.toString(),
        name: index == 0 ? "Your Story" : "User $index",
        profileImageUrl: FileConstants.profile,
        hasStory: index != 0,
      ),
    );

    // Sample data for chat list
    final List<ChatPreview> chats = List.generate(
      15,
      (index) => ChatPreview(
        user: User(
          id: "user$index",
          name: "Shiro Watson",
          profileImageUrl: FileConstants.profile,
        ),
        lastMessage: "How are you?",
        timestamp: DateTime.now().subtract(Duration(minutes: index * 5)),
        unreadCount: index % 3 == 0 ? index : 0,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: const Text(
          "Messages",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor),
        ),
        leading: IconButton(
          color: AppColors.blackColor,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          // User group icon button
          Container(
              height: 30.h,
              width: 40.w,
              padding: EdgeInsets.all(8.w),
              margin: EdgeInsets.only(right: 1.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                FileConstants.profile,
                width: 15.w,
              )),
          // New message icon button
          Container(
              padding: EdgeInsets.all(8.w),
              height: 30.h,
              width: 40.w,
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                FileConstants.plus,
                width: 15.w,
                color: AppColors.blackColor,
              )),
        ],
      ),
      body: Column(
        children: [
          // Stories section
          Container(
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey[50],
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: storyUsers.length,
              itemBuilder: (context, index) {
                final user = storyUsers[index];
                return StoryCircle(
                  user: user,
                  isFirst: index == 0,
                );
              },
            ),
          ),

          // Chat list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              itemCount: chats.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 76,
                endIndent: 16,
                color: Colors.black12,
              ),
              itemBuilder: (context, index) {
                return ChatUserCard(chat: chats[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable component for story/status circles
class StoryCircle extends StatelessWidget {
  final User user;
  final bool isFirst;

  const StoryCircle({
    super.key,
    required this.user,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFirst ? Colors.grey[200] : Colors.white,
              border: Border.all(
                color: user.hasStory ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: isFirst
                ? const Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black54,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      user.profileImageUrl,
                      fit: BoxFit.cover,
                      // Using placeholder for example
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            isFirst ? "Your Story" : user.name.split(" ")[0],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Reusable ChatUserCard component for conversations list
class ChatUserCard extends StatelessWidget {
  final ChatPreview chat;

  const ChatUserCard({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to chat screen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            // CircleAvatar(
            //   radius: 24,
            //   backgroundImage: NetworkImage(chat.user.profileImageUrl),
            //   onBackgroundImageError: (_, __) {},
            //   child: NetworkImage(chat.user.profileImageUrl).resolve(const ImageConfiguration()).addListener(
            //     ImageStreamListener((_, __) {}, onError: (_, __) {

            //     }),
            //   ),
            // ),
            const SizedBox(width: 12),
            // Message preview content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chat.user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Timestamp
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(chat.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                if (chat.unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time).toUpperCase();
  }
}

// Data models
class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final bool hasStory;

  User({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    this.hasStory = false,
  });
}

class ChatPreview {
  final User user;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isTyping;

  ChatPreview({
    required this.user,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isTyping = false,
  });
}
