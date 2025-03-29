import 'dart:developer';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/auth_provider.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:frappe_flutter_app/widgets/small_textfield.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  SignUpScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _signup(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // if (_formKey.currentState!.validate()) {
    try {
      final isSignedUp = await authProvider.signup(
          email: _emailController.text,
          password: _passwordController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          mobileNumber: _mobileNoController.text,
          profilePicUrl: '',
          location: '',
          latitude: 0.0,
          longitude: 0.0,
          bio: '',
          birthDate: "",
          gender: '',
          idNumber: '',
          idPhotoUrl: '',
          interests: ['Technology']);
      if (isSignedUp) {
        _showSuccessDialog(context);
      } else {
        _showErrorDialog(context, 'Signup failed. Please try again.');
      }
    } catch (e, t) {
      SnackbarGlobal.show('Login Failed: $e');
      log(t.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      _buildSignUpForm(context),
                      Image.asset(
                        FileConstants.rectangle,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Image.asset(
          //     FileConstants.rectangle,
          //     fit: BoxFit.fill,
          //   ),
          // ),
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

  Widget _buildSignUpForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h, top: 4.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.accentBlueColor,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              "CREATE YOUR ACCOUNT",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 14.h,
            ),
            SmallTextfield(
              label: 'First name',
              controller: _firstNameController,
              obscureText: false,
            ),
            SizedBox(height: 12.h),
            SmallTextfield(
              label: 'Last name',
              controller: _lastNameController,
              obscureText: false,
            ),
            SizedBox(height: 12.h),
            SmallTextfield(
              label: 'Mobile No.',
              controller: _mobileNoController,
              obscureText: false,
            ),
            SizedBox(height: 12.h),
            SmallTextfield(
              label: 'Email',
              controller: _emailController,
              obscureText: false,
            ),
            SizedBox(height: 12.h),
            SmallTextfield(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 12.h),
            SmallTextfield(
              label: 'Confirm password',
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 15.h),
            CustomElevatedButton(
              onPressed: () {
                log("button pressed signup");
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return UploadPhotoScreen();
                // }));
                _signup(context);
              },
              label: 'Sign Up',
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () => context.push(RouteConstants.login),
                  child: Text(
                    ' Sign in',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Error dialog for showing password mismatch or signup failure
void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// Success dialog for successful signup
void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Signup successful!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context
                  .push(RouteConstants.home); 
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
