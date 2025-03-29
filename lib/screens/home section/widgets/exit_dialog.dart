import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Exit App"),
      content: const Text("Are you sure you want to exit?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("No"),
        ),
        SizedBox(height: 6.h,),
        TextButton(
          onPressed: () => exit(0),
          child: const Text("Yes"),
        ),
      ],
    ),
  ) ?? false;
}
