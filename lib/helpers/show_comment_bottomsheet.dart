import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/view_comments_screen.dart';
import 'package:provider/provider.dart';

void showCommentsBottomSheet(BuildContext context, int postId, int userId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
        value: Provider.of<PostProvider>(context, listen: false),
        child: CommentsBottomSheet(postId: postId, userId: userId),
      );
    },
  );
}
