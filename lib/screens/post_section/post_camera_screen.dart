import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:frappe_flutter_app/providers/photo_provider.dart';
import 'package:frappe_flutter_app/screens/post_section/post_detail_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:frappe_flutter_app/utilities/common_utilities.dart';

class BusinessPostCameraScreen extends StatelessWidget {
  const BusinessPostCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Want to post about Business?',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          photoProvider.takePicture();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12.r),
                          dashPattern: [8, 4],
                          color: AppColors.primaryColor,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.64,
                            color: Colors.grey.shade100,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          // photoProvider.pickImageFromGallery();
                          //navigate to businesspostdetails screen
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BusinessPostDetailsScreen();
                          }));
                        },
                        child: Container(
                          height: 20.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: AppColors.selectedButtonColor),
                          child: const Center(child: Text("Gallery")),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Bottom section with line and icons
              Stack(
                alignment: Alignment.center,
                children: [
                  // Grey divider line
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(
                        top: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.text_fields),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.bar_chart_rounded),
                          onPressed: () {},
                        ),
                        // Large centered circle
                        Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.blackColor,
                              width: 1,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
