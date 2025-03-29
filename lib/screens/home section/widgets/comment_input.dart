import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:provider/provider.dart';

class CommentInputWidget extends StatefulWidget {
  final int userId;
  final int postId;

  const CommentInputWidget({
    Key? key,
    required this.userId,
    required this.postId,
  }) : super(key: key);

  @override
  _CommentInputWidgetState createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                suffixIcon: postProvider.isPostingComment
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          if (_commentController.text.isNotEmpty) {
                            final success = await postProvider.postComment(
                              widget.userId,
                              widget.postId,
                              _commentController.text,
                            );
                            if (success) {
                              _commentController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Comment posted successfully')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to post comment')),
                              );
                            }
                          }
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
