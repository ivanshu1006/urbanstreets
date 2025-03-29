import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class CommunityButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? width;
  final double? height;

  const CommunityButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
    this.backgroundColor,
    this.labelColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Use provided or default background color
        backgroundColor: backgroundColor ?? (isSelected ? AppColors.primaryColor : Colors.grey[300]),
        
        // Remove default elevation and padding
        elevation: 0,
        padding: EdgeInsets.zero,
        
        // Match the button shape from the image
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        
        // Specify fixed or flexible width
        fixedSize: width != null && height != null
          ? Size(width!, height!)
          : Size.fromHeight(48.h),
      ),
      child: Text(
        label,
        style: TextStyle(
          // Use provided or default text color
          color: labelColor ?? (isSelected ? Colors.white : Colors.black),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}