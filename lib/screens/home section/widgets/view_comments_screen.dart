import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:provider/provider.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int postId;
  final int userId;

  const CommentsBottomSheet({
    Key? key,
    required this.postId,
    required this.userId,
  }) : super(key: key);

  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch comments when the bottom sheet is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false)
          .fetchComments(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                // Comments List
                Expanded(
                  child: postProvider.isFetchingComments
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: postProvider.comments.length,
                          itemBuilder: (context, index) {
                            final comment = postProvider.comments[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(comment.user.username[0]),
                              ),
                              title: Text(comment.user.username),
                              subtitle: Text(comment.commentText),
                            );
                          },
                        ),
                ),
                const Divider(),
                // Comment Input Field
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    suffixIcon: postProvider.isPostingComment
                        ? const Text('Posting..')
                        : IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () async {
                              if (_commentController.text.isNotEmpty) {
                                final success = await postProvider.postComment(
                                  widget.userId,
                                  widget.postId,
                                  _commentController.text,
                                );
                                if (success) {
                                  _commentController.clear();
                                  SnackbarGlobal.show('Comment posted successfully',backgroundColor: AppColors.primaryColor);
                                } else {
                                   SnackbarGlobal.show('Failed to Ppost Comment',backgroundColor: AppColors.errorColor);
                                }
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
