import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
class BusinessPostDetailsScreen extends StatefulWidget {
  final File? imageFile;

  const BusinessPostDetailsScreen({Key? key, this.imageFile}) : super(key: key);

  @override
  _BusinessPostDetailsScreenState createState() =>
      _BusinessPostDetailsScreenState();
}

class _BusinessPostDetailsScreenState extends State<BusinessPostDetailsScreen> {
  bool _isCommunityTagged = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:   Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: AssetImage(FileConstants.cover), // Replace with actual profile image
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joseph',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Post to anyone',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: AppColors.accentBlueColor,
          ),
            height: 30.h,
            width: 80.w,
            child: Center(
              child: Text(
                  'Post',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ),
          // TextButton(
            
          //   onPressed: () {
          //     // Implement post functionality
          //   },
          //   child: Text(
          //     'Post',
          //     style: TextStyle(
          //       color: AppColors.primaryColor,
          //       fontSize: 16.sp,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Truck Image
              Container(
                width: double.infinity,
                height: 200.h,
                margin: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: widget.imageFile != null 
                    ? DecorationImage(
                        image: FileImage(widget.imageFile!),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: AssetImage(FileConstants.cover),
                        fit: BoxFit.cover,
                      ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),

              // Description TextField
              TextField(
                decoration: InputDecoration(
                  hintText: 'Add Description',
                  filled: true,
                  fillColor: AppColors.accentBlueColor,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
                maxLines: 4,
              ),

              SizedBox(height: 16.h),

              // Community Tagging Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _isCommunityTagged = true),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 0.h,
                          ),
                          decoration: BoxDecoration(
                            color: _isCommunityTagged ? AppColors.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: _isCommunityTagged ? AppColors.primaryColor : Colors.grey,
                            ),
                          ),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: _isCommunityTagged ? Colors.white : Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () => setState(() => _isCommunityTagged = false),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 0.h,
                          ),
                          decoration: BoxDecoration(
                            color: !_isCommunityTagged ? AppColors.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: !_isCommunityTagged ? AppColors.primaryColor : Colors.grey,
                            ),
                          ),
                          child: Text(
                            'No',
                            style: TextStyle(
                              color: !_isCommunityTagged ? Colors.white : Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   Text(
                    'Do you want to tag community or business?',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Search Community
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Community',
                  filled: true,
                  fillColor: AppColors.accentBlueColor,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.sp,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  
                  enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.text_fields, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
              onPressed: () {},
            ),
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: AppColors.primaryColor),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.primaryColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// class BusinessPostDetailsScreen extends StatefulWidget {
//   const BusinessPostDetailsScreen({Key? key}) : super(key: key);

//   @override
//   _BusinessPostDetailsScreenState createState() => _BusinessPostDetailsScreenState();
// }

// class _BusinessPostDetailsScreenState extends State<BusinessPostDetailsScreen> {
//   bool _isCommunityTagged = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
      
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20.r,
//               backgroundImage: AssetImage(FileConstants.cover), // Replace with actual profile image
//             ),
//             SizedBox(width: 10.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Joseph',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Post to anyone',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Implement post functionality
//             },
//             child: Text(
//               'Post',
//               style: TextStyle(
//                 color: AppColors.primaryColor,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Food Truck Image
//               Container(
//                 width: double.infinity,
//                 height: 200.h,
//                 margin: EdgeInsets.symmetric(vertical: 16.h),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12.r),
//                   image: DecorationImage(
//                     image: AssetImage(FileConstants.cover), // Replace with actual image
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.r),
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.1),
//                         Colors.black.withOpacity(0.5),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Description TextField
//               TextField(

//                 decoration: InputDecoration(
//                   hintText: 'Add Description',
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16.sp,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                     borderSide: BorderSide(color: AppColors.primaryColor),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                     borderSide: BorderSide(color: AppColors.primaryColor),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 12.w,
//                     vertical: 12.h,
//                   ),
//                 ),
//                 maxLines: 4,
//               ),

//               SizedBox(height: 16.h),

//               // Community Tagging Toggle
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Do you want to tag community or business?',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () => setState(() => _isCommunityTagged = true),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 12.w,
//                             vertical: 6.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _isCommunityTagged ? AppColors.primaryColor : Colors.white,
//                             borderRadius: BorderRadius.circular(20.r),
//                             border: Border.all(
//                               color: _isCommunityTagged ? AppColors.primaryColor : Colors.grey,
//                             ),
//                           ),
//                           child: Text(
//                             'Yes',
//                             style: TextStyle(
//                               color: _isCommunityTagged ? Colors.white : Colors.black,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8.w),
//                       GestureDetector(
//                         onTap: () => setState(() => _isCommunityTagged = false),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 12.w,
//                             vertical: 6.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: !_isCommunityTagged ? AppColors.primaryColor : Colors.white,
//                             borderRadius: BorderRadius.circular(20.r),
//                             border: Border.all(
//                               color: !_isCommunityTagged ? AppColors.primaryColor : Colors.grey,
//                             ),
//                           ),
//                           child: Text(
//                             'No',
//                             style: TextStyle(
//                               color: !_isCommunityTagged ? Colors.white : Colors.black,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               SizedBox(height: 16.h),

//               // Search Community
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search Community',
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16.sp,
//                   ),
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 12.w,
//                     vertical: 12.h,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       // Bottom Navigation
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(Icons.text_fields, color: Colors.grey),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
//               onPressed: () {},
//             ),
//             Container(
//               width: 60.w,
//               height: 60.h,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.edit_outlined, color: AppColors.primaryColor),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: Icon(Icons.search, color: AppColors.primaryColor),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BusinessPostDetailsScreen extends StatefulWidget {
//   final String imagePath;

//   const BusinessPostDetailsScreen({Key? key, required this.imagePath}) : super(key: key);

//   @override
//   _BusinessPostDetailsScreenState createState() => _BusinessPostDetailsScreenState();
// }

// class _BusinessPostDetailsScreenState extends State<BusinessPostDetailsScreen> {
//   bool _isCommunityTagged = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           TextButton(
//             child: Text(
//               'Post',
//               style: TextStyle(
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onPressed: () {
//               // Implement post functionality
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     image: FileImage(File(widget.imagePath)),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Add Description',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 ),
//                 maxLines: 4,
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Do you want to tag community or business?',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Switch(
//                     value: _isCommunityTagged,
//                     onChanged: (bool value) {
//                       setState(() {
//                         _isCommunityTagged = value;
//                       });
//                     },
//                     activeColor: AppColors.primaryColor,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search Community',
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }