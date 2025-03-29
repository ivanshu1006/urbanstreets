// import 'package:frappe_flutter_app/core/barrel_file.dart';
// import 'package:frappe_flutter_app/repositories/auth_repository.dart';
// import 'package:frappe_flutter_app/services/connectivity_service.dart';

// import 'package:frappe_flutter_app/widgets/app_drawer.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isConnected = context.watch<ConnectivityService>().isConnected;

//     return Scaffold(

//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: !isConnected
//           ? const OfflineWidget()
//           : Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Welcome to the Home Screen!'),
//                   ElevatedButton(
//                     onPressed: (){},
//                     child: const Text("Get Data"),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }

// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/auth_provider.dart';
import 'package:frappe_flutter_app/screens/chat_section/chat_list_screen.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/exit_dialog.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/posts_list_widget.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/status_input_widget.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/stories_section_widget.dart';
import 'package:frappe_flutter_app/screens/profile_section/my_profile_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmed = await showExitConfirmationDialog(context);
        if (exitConfirmed) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding:
                     EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      FileConstants.primaryLogo,
                      height: 40.h,
                      width: 170.w,
                    ),
                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            _buildIconButton(Icons.search, () {}),
                            _buildIconButton(Icons.store, () {
                              value.logout();
                              context.go(RouteConstants.login);
                            }),
                            _buildIconButton(Icons.chat_bubble_outline, () {
                              context.push(RouteConstants.messagesList);
                            }),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  children: [
                    StatusInput(),
                    StoriesSection(),
                    Divider(
                        height: 1, thickness: 1, color: AppColors.whiteColor),
                    Expanded(child: PostListScreen()),
                  ],
                ),
              ),

              // Bottom Navigation
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(FileConstants.home, true),
                    _buildNavItem(FileConstants.profile, false),
                    _buildNavItem(FileConstants.cam, false),
                    _buildNavItem(FileConstants.attachments, false),
                    GestureDetector(
                      onTap: () {
                       context.push(RouteConstants.myprofile);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundImage: AssetImage(FileConstants.profile),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildNavItem(String image, bool isSelected) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        image,
        // color: isSelected ? Colors.black : Colors.grey,
        width: 20.w,
        height: 26.h,
      ),
    );
  }
}
