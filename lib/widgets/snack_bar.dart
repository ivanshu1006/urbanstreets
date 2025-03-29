import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class SnackbarGlobal {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(
    String message, {
    Color textColor = Colors.white,
    Color backgroundColor = AppColors.blackColor,
  }) {
    key.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
      ));
  }
}
