import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double height;
  final double width;
  final bool isPrimary;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 45.0,
    this.width = 110.0,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height.h,
        width: width.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? Colors.white : AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 4,
            shadowColor: const Color(0xFF4080FF).withOpacity(0.4),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isPrimary ? AppColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
