import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/constants/file_constants.dart';
import 'package:frappe_flutter_app/constants/routes_constant.dart';
import 'package:frappe_flutter_app/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));

    // Check if the user is authenticated
    final isAuthenticated = await Utils.checkAuthentication();

   // Navigate to the appropriate screen
    if (isAuthenticated) {
      context.go(RouteConstants.home);
    } else {
      context.go(RouteConstants.login); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              FileConstants.urbanLogo,
              height: 150,
            ),
           
          ],
        ),
      ),
    );
  }
}