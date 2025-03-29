import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/photo_provider.dart';
import 'package:frappe_flutter_app/screens/business_community_section/community_registered_screen.dart';
import 'package:frappe_flutter_app/screens/business_community_section/widgets/button.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:frappe_flutter_app/widgets/custom_elevated_button.dart';

class CommunityDocumentsScreen extends StatefulWidget {
  const CommunityDocumentsScreen({Key? key}) : super(key: key);

  @override
  _CommunityDocumentsScreenState createState() => _CommunityDocumentsScreenState();
}

class _CommunityDocumentsScreenState extends State<CommunityDocumentsScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.w,color: AppColors.blackColor,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Business', style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor)),
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
              padding: EdgeInsets.all(16.w),
              child: Form(
              
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    
                      SizedBox(height: 24.h),

                      // Dynamic Fields based on selected action
                      Text(
                        'Add Personal Details',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Enter the below details to create Community',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16.h),

                     _buildPersonalDocumentsSection(),

                      SizedBox(height: 24.h),

                      // Continue and Cancel Buttons
                      CustomElevatedButton(
                        width: 400.w,
                        label: 'Continue',
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityRegisteredScreen()));
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomElevatedButton(
                        width: 400.w,
                        isPrimary: true,
                        label: 'Cancel',
                        onPressed: (){},
                      ),
                    ],
                  ),
                ),
              ),
            ),
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