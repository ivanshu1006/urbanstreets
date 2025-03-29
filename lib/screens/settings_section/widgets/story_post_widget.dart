import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/model/story_posts_models/story_post_model.dart';

class StoryPostWidget extends StatelessWidget {
  final StoryPostModel post;

  const StoryPostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Post Image
          Image.asset(
            post.imageUrl,
            fit: BoxFit.cover,
          ),
          
          // Date Overlay
          Positioned(
            top: 8.w,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                post.date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
