import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/profile_provider.dart';
import 'package:frappe_flutter_app/screens/profile_section/widgets/textfield.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class CreateCommunityScreen extends StatefulWidget {
  @override
  _CreateCommunityScreenState createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    categoryController.dispose();
    addressController.dispose();
    detailsController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Community Details",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Enter the below details to create Community",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BlueTextField(
                      controller: nameController,
                      hintText: "Community name",
                    ),
                    SizedBox(height: 12.h),
                    BlueTextField(
                      controller: emailController,
                      hintText: "Community email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 14.h),
                    BlueTextField(
                      controller: mobileController,
                      hintText: "Community mobile number",
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 12.h),
                    BlueTextField(
                      controller: categoryController,
                      hintText: "Community category",
                    ),
                    SizedBox(height: 12.h),
                    BlueTextField(
                      controller: addressController,
                      hintText: "Community address",
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    BlueTextField(
                      controller: detailsController,
                      hintText: "Community details",
                      maxLines: 4,
                    ),
                    SizedBox(height: 32),
                    CustomElevatedButton(
                      label: "Submit",
                      onPressed: () {
                        final profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false);

                        profileProvider.createCommunity(
                          adminId: 1,
                          communityName: nameController.text,
                          communityEmail: emailController.text,
                          communityMobileNumber: mobileController.text,
                          communityCategory: categoryController.text,
                          communityAddress: addressController.text,
                          communityDescription: detailsController.text,
                          members: 0,
                          coverPhotoUrl: '',
                        );

                        // if (profileProvider.errorMessage != null) {
                        //   SnackbarGlobal.show(profileProvider.errorMessage.toString());
                        // } else {
                        //   SnackbarGlobal.show("Community created successfullyy");
                        // }
                      },
                      width: 90.w,
                      height: 25.h,
                    ),
                    SizedBox(height: 16),
                    CustomElevatedButton(
                      label: "Cancel",
                      width: 400.w,
                      isPrimary: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 16),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back_ios, size: 20.sp),
          ),
          SizedBox(width: 8.w),
          Text(
            "Create Community",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}



