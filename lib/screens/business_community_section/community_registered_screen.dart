import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/photo_provider.dart';
import 'package:frappe_flutter_app/screens/business_community_section/widgets/button.dart';
import 'package:frappe_flutter_app/screens/profile_section/widgets/textfield.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:frappe_flutter_app/widgets/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';

class CommunityRegisteredScreen extends StatefulWidget {
  const CommunityRegisteredScreen({Key? key}) : super(key: key);

  @override
  _CommunityRegisteredScreenState createState() =>
      _CommunityRegisteredScreenState();
}

class _CommunityRegisteredScreenState extends State<CommunityRegisteredScreen> {
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _businessDetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22.w,
            color: AppColors.blackColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Business',
            style: TextStyle(fontSize: 18.sp, color: AppColors.blackColor)),
      ),
      body: Column(
        children: [
          // Progress Indicator Slider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: LinearProgressIndicator(
              value: 0.25, // First step of 4 steps
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:50.w),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),

                      // Dynamic Fields based on selected action
                      Text(
                        'You have successfully registered',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Please name the community.You can add post, videos, polls, etc in the community',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Your Business Name',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      SizedBox(height:10.h),
                      BlueTextField(
                        controller: _businessNameController,
                        hintText: "Business Name",
                      ),
                                            SizedBox(height:10.h),

                        Text(
                        'Business Details',
                        style: TextStyle(
                          fontSize: 12.sp,
                        color: AppColors.blackColor,
                        ),
                      ),
                         SizedBox(height:10.h),
                      BlueTextField(
                        controller: _businessDetailController,
                        hintText: "Business Details",
                        maxLines: 4,
                      ),

                      // SizedBox(height: 140.h),

                      // Continue and Cancel Buttons
                     
                    ],
                  ),
                ),
              ),
            ),
            
          ),
           Padding(
             padding:  EdgeInsets.all(25.w),
             child: CustomElevatedButton(
                          width: 400.w,
                          label: 'Continue',
                          onPressed: () {},
                        ),
           ),
                      SizedBox(height: 12.h),
                      CustomElevatedButton(
                        width: 400.w,
                        isPrimary: true,
                        label: 'Cancel',
                        onPressed: () {},
                      ),
          
        ],
      ),
    );
  }

  Widget _buildDocumentItem(String title) {
    return GestureDetector(
      onTap: () {
        final photoProvider =
            Provider.of<PhotoProvider>(context, listen: false);
        photoProvider.showImageSourceOptions(context);
      },
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 36.sp,
              color: Colors.black87,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalDocumentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Documents",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildDocumentItem("Land Paper\n(Front)"),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildDocumentItem("Land Paper\n(Back)"),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildDocumentItem("Land Paper\n(Front)"),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildDocumentItem("Land Paper\n(Back)"),
            ),
          ],
        ),
      ],
    );
  }
}
