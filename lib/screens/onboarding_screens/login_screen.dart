import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/auth_provider.dart';
import 'package:frappe_flutter_app/screens/onboarding_screens/signup_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: LoginScreenState(),
    );
  }
}

class LoginScreenState extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      final email = _userIdController.text;
      final password = _passwordController.text;

      try {
        final isLoggedIn = await authProvider.login(email, password);
        if (isLoggedIn) {
          context.go(RouteConstants.home);
        }
      } catch (e) {
        SnackbarGlobal.show('Login Failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background and content
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      _buildLoginForm(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom wave decoration
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              FileConstants.ellipse123,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 40, 0),
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

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 380.h,
        margin: EdgeInsets.all(20.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.accentBlueColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LOGIN TO YOUR ACCOUNT",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.h),
            CustomInputField(
              label: 'User_Id',
              controller: _userIdController,
              obscureText: false,
            ),
            SizedBox(height: 18.h),
            CustomInputField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 26.h),
            CustomElevatedButton(
              onPressed: () => _login(context),
              label: 'Log In',
            ),
            SizedBox(height: 34.h),
            _buildSignUpOption(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't Have a Account ? ",
          style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
