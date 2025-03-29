import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';

class LikeButton extends StatefulWidget {
  final int userId;
  final int postId;

  const LikeButton({Key? key, required this.userId, required this.postId}) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PostProvider>(context, listen: false)
          .checkIfPostLiked(widget.userId, widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        bool isLiked = postProvider.isPostLiked(widget.postId);

        return IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : Colors.black,
          ),
          onPressed: () {
            postProvider.toggleLikePost(widget.userId, widget.postId);
          },
        );
      },
    );
  }
}
