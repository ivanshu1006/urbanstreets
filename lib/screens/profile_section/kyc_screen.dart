import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/photo_provider.dart';
import 'package:frappe_flutter_app/providers/profile_provider.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class KYCScreen extends StatefulWidget {
  @override
  _KYCScreenState createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  final TextEditingController idNumberController = TextEditingController();
  String? selectedPhotoPath;

  @override
  void dispose() {
    idNumberController.dispose();
    super.dispose();
  }

  void _pickImageFromCamera() async {
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    photoProvider.takePicture();
  }

  void _pickImageFromGallery() async {
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    photoProvider.pickImageFromGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIdNumberSection(),
                    SizedBox(height: 24.h),
                    _buildPhotoUploadSection(),
                    SizedBox(height: 24.h),
                    _buildPersonalDocumentsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back_ios, size: 20.sp),
              ),
              SizedBox(width: 16.w),
              Text(
                "KYC",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          CustomElevatedButton(
            label: "Submit",
            onPressed: () {
              final profileProvider =
                  Provider.of<ProfileProvider>(context, listen: false);
              String idNumber = idNumberController.text.trim();

              log(idNumber);
              log(selectedPhotoPath.toString());

              if (idNumber.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please fill all fields")),
                );
                return;
              }

              profileProvider.applyKyc(idNumber,3);
            },
            width: 90.w,
            height: 25.h,
          ),
        ],
      ),
    );
  }

  Widget _buildIdNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Id Number",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: TextField(
            controller: idNumberController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload your photo",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _pickImageFromGallery,
          child: Container(
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Center(
              child: selectedPhotoPath != null
                  ? Image.file(
                      File(selectedPhotoPath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180.h,
                    )
                  : Image.asset(FileConstants.attachments,
                      width: 30.w, height: 30.h),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _pickImageFromCamera,
          child: Row(
            children: [
              Icon(Icons.camera_alt, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                "From the Device",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
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
}



// // Make sure you have these classes defined in your project
// // If not already defined, add these to your project

// class CustomElevatedButton extends StatelessWidget {
//   final String text;
//   final bool isPrimary;
//   final VoidCallback onPressed;
//   final double? width;
//   final double height;
//   final double borderRadius;

//   const CustomElevatedButton({
//     Key? key,
//     required this.text,
//     required this.isPrimary,
//     required this.onPressed,
//     this.width,
//     this.height = 54,
//     this.borderRadius = 12,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width ?? double.infinity,
//       height: height,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isPrimary ? Colors.blue : Colors.white,
//           foregroundColor: isPrimary ? Colors.white : Colors.black,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             side: BorderSide(
//               color: isPrimary ? Colors.transparent : AppColors.primaryColor,
//               width: 1,
//             ),
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Here's a sample implementation of PhotoProvider if you don't have one:
/*
class PhotoProvider extends ChangeNotifier {
  void showImageSourceOption(BuildContext context, Function(String?) onImageSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 150,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                _getImage(ImageSource.camera, onImageSelected);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                _getImage(ImageSource.gallery, onImageSelected);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source, Function(String?) onImageSelected) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    
    if (pickedFile != null) {
      onImageSelected(pickedFile.path);
    } else {
      onImageSelected(null);
    }
  }
}
*/