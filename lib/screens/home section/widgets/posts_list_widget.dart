import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/post_item_widget.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:provider/provider.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    super.initState();
  Future.microtask(() {
     _fetchPosts();
    });
  }

  void _fetchPosts() async {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    await postProvider.fetchUserPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        final posts = postProvider.posts;
        final isLoading = postProvider.isLoading;

        return RefreshIndicator(
          onRefresh: () async => await postProvider.fetchUserPosts(),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : posts.isEmpty
                  ? const Center(child: Text("No posts available"))
                  : Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: posts.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.whiteColor,
                        ),
                        itemBuilder: (context, index) {
                          print(posts.length);
                          return PostItemWidget(post: posts[index]);
                        },
                      ),
                    ),
        );
      },
    );
  }
}
