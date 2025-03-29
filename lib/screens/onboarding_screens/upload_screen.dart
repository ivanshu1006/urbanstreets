import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/constants/file_constants.dart';
import 'package:frappe_flutter_app/constants/routes_constant.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/location_provider.dart';
import 'package:frappe_flutter_app/providers/photo_provider.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/interst_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:frappe_flutter_app/widgets/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class UploadPhotoScreen extends StatelessWidget {
  const UploadPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _UploadPhotoScreenContent();
  }
}

class _UploadPhotoScreenContent extends StatelessWidget {
  const _UploadPhotoScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final photoProvider = Provider.of<PhotoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 16.h, top: 4.h),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlueColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Text(
                        'Upload your photo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Photo container - Now with gesture detector
                      GestureDetector(
                        onTap: () {
                          // Show options to take picture or select from gallery
                          photoProvider.showImageSourceOptions(context);
                        },
                        child: Container(
                          height: 160.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: photoProvider.pickedImage == null
                              ? photoProvider.isLoading 
                                  ? const Center(child: CircularProgressIndicator())
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          FileConstants.camera,
                                          height: 30.w,
                                          width: 26.w,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          '/',
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        SizedBox(width: 8.w),
                                        Image.asset(
                                          FileConstants.attachments,
                                          height: 30.w,
                                          width: 20.w,
                                        ),
                                      ],
                                    )
                              : Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Image.file(
                                        File(photoProvider.pickedImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Add a remove button
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: photoProvider.clearImage,
                                        child: Container(
                                          padding: EdgeInsets.all(6.w),
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'From the Device',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          // Location input
                          SizedBox(
                            height: 28.h,
                            width: 200.w,
                            child: TextField(
                              controller: locationProvider.locationController,
                              decoration: InputDecoration(
                                hintText: 'Your location',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Map container
                      Container(
                        height: 170.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Stack(
                            children: [
                              locationProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : FlutterMap(
                                      mapController:
                                          locationProvider.mapController,
                                      options: MapOptions(
                                        initialCenter:
                                            locationProvider.selectedLocation ??
                                                const LatLng(0, 0),
                                        initialZoom: 15.0,
                                        maxZoom: 18.0,
                                        minZoom: 3.0,
                                        onTap: locationProvider.onMapTapped,
                                        onMapReady:
                                            locationProvider.initMapController,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            if (locationProvider
                                                    .selectedLocation !=
                                                null)
                                              Marker(
                                                width: 40.w,
                                                height: 40.h,
                                                point: locationProvider
                                                    .selectedLocation!,
                                                child: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.red,
                                                  size: 40,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                              Positioned(
                                bottom: 12,
                                right: 12,
                                child: GestureDetector(
                                  onTap: locationProvider.centerMap,
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.navigation,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Add live location button
                      GestureDetector(
                        onTap: locationProvider.initializeLocation,
                        child: Row(
                          children: [
                            Image.asset(
                              FileConstants.periscope,
                              height: 28.w,
                              width: 26.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Add Live Location',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Updated to use CustomElevatedButton
                      CustomElevatedButton(
                        label: 'Continue',
                        onPressed: () {
                          // You might want to add validation here
                          // Check if an image has been selected
                          if (photoProvider.pickedImage == null) {
                            SnackbarGlobal.show('Please select a photo');
                            return;
                          }
                         Navigator.push(context, MaterialPageRoute(builder:  (context) => const InterstScreen()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
         
          // Positioned(
          //   bottom: -8.h,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset(
          //     FileConstants.ellipse124,
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 60.h, 40.w, 0),
      child: Row(
        children: [
          Image.asset(
            FileConstants.primaryLogo,
            height: 40.h,
            width: 200.w,
          )
        ],
      ),
    );
  }
}

// For handling location permission errors
class LocationErrorHandler {
  static void showLocationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}