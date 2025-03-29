import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class SmallTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const SmallTextfield({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
         SizedBox(height: 8.h),
        SizedBox(
          height: 30.h,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 12.h,
              ),
              filled: true,
              fillColor: AppColors.whiteColor,
              border: InputBorder.none, // Remove border from all sides
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r), // Circular border radius
                borderSide: BorderSide.none, // No border side
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r), // Circular border radius
                borderSide: BorderSide.none, // No border side
              ),
            ),
          ),
        ),
      ],
    );
  }
}
