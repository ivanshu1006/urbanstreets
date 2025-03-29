// lib/widgets/post_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/helpers/show_comment_bottomsheet.dart';
import 'package:frappe_flutter_app/model/posts_section_models/get_user_post_model.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/comment_input.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/follow_button.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/like_button_widget.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/page_indicator_widget.dart';
import 'package:frappe_flutter_app/screens/home%20section/home_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class PostItemWidget extends StatelessWidget {
  final GetUserPostsModel post;

  const PostItemWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile information
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(post.personalPhotoUrl.toString()),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userId.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        post.createdAt.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Follow button
              FollowButton(followerId: 1, followingId: 2),

              // Row(
              //   children: [
              //     // Text(
              //     FollowButton(followerId: 1, followingId: post.userId!),
              //     //   'Follow',
              //     //   style: TextStyle(
              //     //       color: AppColors.primaryColor, fontSize: 13.sp),
              //     // ),
              //     // Icon(
              //     //   Icons.add,
              //     //   size: 14.sp,
              //     //   color: AppColors.primaryColor,
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              FileConstants.urbanLogo,
              fit: BoxFit.fill,
              width: double.infinity,
              height: 300,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikeButton(userId: 1, postId: post.postId!),
                  // Consumer<PostProvider>(
                  //   builder: (context, postProvider, child) {
                  //     int userId = 1; // Replace with actual user ID
                  //     int postId = post.postId!;

                  //     // Fetch like status
                  //     postProvider.checkIfPostLiked(userId, postId);

                  //     bool isLiked = postProvider.isPostLiked(postId);

                  //     return IconButton(
                  //       icon: Icon(
                  //         Icons.favorite,
                  //         color: isLiked ? Colors.red : Colors.grey,
                  //       ),
                  //       onPressed: () {
                  //         postProvider.toggleLikePost(userId, postId);
                  //       },
                  //     );
                  //   },
                  // ),

                  // IconButton(
                  //   icon: Icon(
                  //     post. ? Icons.favorite : Icons.favorite_border,
                  //     color: post.isLiked ? Colors.red : Colors.black,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.favorite_border,
                  //     color: Colors.red,
                  //   ),
                  //   onPressed: () {},
                  // ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    onPressed: () {
                       showCommentsBottomSheet(context, post.postId!, 1);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  const PageIndicator(currentPage: 0, totalPages: 5),
                  IconButton(
                    icon: const Icon(Icons.sync),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),

        // Post Stats and Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${post.likes} Likes',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  children: [
                    TextSpan(
                      text: post.personalDescription.toString() + ' ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: post.createdAt.toString() + ' '),
                    // if (post..length > 80)
                    //   const TextSpan(
                    //     text: ' more',
                    //     style: TextStyle(color: Colors.grey),
                    //   ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showCommentsBottomSheet(context, post.postId!, 1);
                },
                child: Text(
                  'View all ${post.comments.toString()} comments',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Comment Input Field
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        NetworkImage(post.personalPhotoUrl.toString()),
                  ),
                  const SizedBox(width: 12),
                  // Text(
                  //   'Add a comment...',
                  //   style: TextStyle(
                  //     color: Colors.grey.shade600,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // Expanded(child: CommentInputWidget(userId: 1, postId: post.postId!)),
                  // IconButton(
                  //   icon: const Icon(Icons.add_circle_outline),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:frappe_flutter_app/providers/post_provider.dart';
// import 'package:frappe_flutter_app/model/posts_section_models/get_user_post_model.dart';

// class PostItemWidget extends StatelessWidget {
//   final GetUserPostsModel post;

//   const PostItemWidget({Key? key, required this.post}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (post.title != null)
//               Text(
//                 post.title!,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             const SizedBox(height: 8),
//             if (post.personalDescription != null)
//               Text(
//                 post.personalDescription!,
//                 style: const TextStyle(fontSize: 14),
//               ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Consumer<PostProvider>(
//                   builder: (context, postProvider, child) {
//                     return IconButton(
//                       icon: Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                       ),
//                       onPressed: () {
//                         postProvider.likePost(post.postId!, post.userId!);
//                       },
//                     );
//                   },
//                 ),
//                 Text('${post.likes} Likes'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
