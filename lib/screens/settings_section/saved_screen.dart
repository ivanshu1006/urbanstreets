import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/theme/theme.dart';
import 'package:go_router/go_router.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar('Saved',context),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.6,
                ),
                children: [
                  SavedItemCard(
                    imageUrl:
                        FileConstants.cover, 
                    title: 'All Posts',
                    onTap: () {
                      // Navigate to All Posts
                    },
                  ),
                  SavedItemCard(
                    icon: FileConstants.musicalnote,
                    imageUrl:
                         FileConstants.cover,
                    title: 'Audio',
                    onTap: () {
                      // Navigate to Audio
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(String title,BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                    context.pop();
                  
                },
                child: Icon(Icons.arrow_back_ios, size: 20.w),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Image.asset(
            FileConstants.plus,
            height: 13.h,
          ),
        ],
      ),
    );
  }
}

class SavedItemCard extends StatelessWidget {
  final String imageUrl;
  final String? icon;
  final String title;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final BoxFit imageFit;

  const SavedItemCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    this.width,
    this.icon,
    this.height,
    this.imageFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width ?? double.infinity,
            height: height ?? 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.r,
                  offset: Offset(0, 4.r),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                imageUrl,
                fit: imageFit,
              ),
            ),
          ),
           SizedBox(height: 8.h),
          Row(
            children: [
              if (icon != null) ...[
                Image.asset(icon!, height: 16.h), 
                 SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
