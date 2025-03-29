import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:provider/provider.dart';

class FollowButton extends StatelessWidget {
  final int followerId;
  final int followingId;

  const FollowButton({
    Key? key,
    required this.followerId,
    required this.followingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return GestureDetector(
          onTap: () async {
            try {
              await postProvider.followUser(followerId, followingId);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.blue, size: 18), // "+" icon
              SizedBox(width: 4),
              Text(
                'Follow',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
