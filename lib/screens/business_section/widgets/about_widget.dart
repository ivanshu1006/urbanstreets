import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/constants/file_constants.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class CompanyAboutWidget extends StatelessWidget {
  final String companyName;
  final String address;
  final String mobile;
  final String email;
  final String website;
  final String category;
  final int reviews;

  const CompanyAboutWidget({
    Key? key,
    required this.companyName,
    required this.address,
    required this.mobile,
    required this.email,
    required this.website,
    required this.category,
    this.reviews = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Section
          _buildSectionTitle('Categories'),
          _buildInfoRow(FileConstants.home, category),
          const SizedBox(height: 16),

          // Contact Info Section
          _buildSectionTitle('Contact Info'),
          _buildInfoRow(FileConstants.homeicon, address),
          _buildInfoRow(FileConstants.phone, mobile),
          _buildInfoRow(FileConstants.letter, email),
          const SizedBox(height: 16),

          // Websites and Social Links
          _buildSectionTitle('Websites and Social Link'),
          _buildInfoRow(FileConstants.link, website),
          const SizedBox(height: 16),

          // Basic Info Section
          _buildSectionTitle('Basic Info'),
          _buildInfoRow(
            FileConstants.star, 
            'Not yet rated ($reviews reviews)',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style:  TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Image.asset(
            icon,
            color: AppColors.blackColor,
            height: 20.h,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style:  TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}