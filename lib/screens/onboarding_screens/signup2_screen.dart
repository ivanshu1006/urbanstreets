// import 'package:frappe_flutter_app/core/barrel_file.dart';
// import 'package:frappe_flutter_app/theme/app_colors.dart';
// import 'package:frappe_flutter_app/widgets/small_textfield.dart';
// import 'package:go_router/go_router.dart';

// class SignUp2Screen extends StatelessWidget {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _mobileNoController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   SignUp2Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       _buildHeader(),
//                       _buildSignUpForm(context),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: -28,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               FileConstants.rectangle,
//               fit: BoxFit.fill,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 60, 40, 0),
//       child: Row(
//         children: [
//           Image.asset(
//             FileConstants.primaryLogo,
//             height: 40.h,
//             width: 200.w,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildSignUpForm(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left:16.w, right: 16.w,bottom: 16.h,top: 4.h),
//       padding: EdgeInsets.all(10.w),
//       decoration: BoxDecoration(
//         color: AppColors.accentBlueColor,
//         borderRadius: BorderRadius.circular(14.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           SizedBox(
//             height: 10.h,
//           ),
//           Text(
//             "CREATE YOUR ACCOUNT",
//             style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 14.h,
//           ),
//           SmallTextfield(
//             label: 'First name',
//             controller: _firstNameController,
//             obscureText: false,
//           ),
//           SizedBox(height: 12.h),
//           SmallTextfield(
//             label: 'Last name',
//             controller: _lastNameController,
//             obscureText: false,
//           ),
//           SizedBox(height: 12.h),
//           SmallTextfield(
//             label: 'Mobile No.',
//             controller: _mobileNoController,
//             obscureText: false,
//           ),
//           SizedBox(height: 12.h),
//           SmallTextfield(
//             label: 'Email',
//             controller: _emailController,
//             obscureText: false,
//           ),
//           SizedBox(height: 12.h),
//           SmallTextfield(
//             label: 'Password',
//             controller: _passwordController,
//             obscureText: true,
//           ),
//           SizedBox(height: 12.h),
//           SmallTextfield(
//             label: 'Confirm password',
//             controller: _confirmPasswordController,
//             obscureText: true,
//           ),
//           SizedBox(height: 15.h),
//           CustomElevatedButton(
//             onPressed: () =>  context.push(RouteConstants.signup), 
//             label: 'Sign Up',
//           ),
//           SizedBox(height: 12.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Already have an account?",
//                 style: TextStyle(
//                     fontSize: 14.sp,
//                     color: AppColors.blackColor,
//                     fontWeight: FontWeight.w700),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   context.go(RouteConstants.upload);
//                 },
//                 child: Text(
//                   ' Sign in',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.h),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
