import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/auth_provider.dart';
import 'package:frappe_flutter_app/screens/settings_section/stories_archieve_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
           _buildAppBar('Settings',context),
          // Search Bar
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: AppColors.accentBlueColor, 
                border: InputBorder.none,
                enabledBorder: InputBorder.none, 
                focusedBorder: InputBorder.none, 
              ),
            ),
          ),


          // Settings Items
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Saved', 
            () {
             context.push(RouteConstants.home);
            }
          ),
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Archive', 
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const StoriesArchiveScreen())); 
            }
          ),
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Your Activity', 
            () {
              // Navigate to Your Activity screen
            }
          ),
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Notification', 
            () {
              // Navigate to Notification settings
            }
          ),
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Blocked', 
            () {
              // Navigate to Blocked users screen
            }
          ),
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Language', 
            () {
              // Navigate to Language selection screen
            }
          ),
          _buildSettingsItem(
            context, 
            FileConstants.profile, 
            'Privacy', 
            () {
              // Navigate to Privacy settings
            }
          ),

          const Spacer(),

          // Add Account and Logout
          _buildAccountAction(
            context, 
            'Add Account', 
            Colors.blue,
            () {
              // Implement add account logic
            }
          ),
          _buildAccountAction(
            context, 
            'Log out', 
            Colors.red,
            () {
              // Implement logout logic
              _showLogoutConfirmDialog(context);
            }
          ),
        ],
      ),
    );
  }
  Widget _buildAppBar(String title,BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back_ios, size: 20.w),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, 
    String imagePath, 
    String title, 
    VoidCallback onTap
  ) {
    return ListTile(
      leading: Image.asset(
        imagePath, 
        width: 24.w, 
        height: 24.h,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildAccountAction(
    BuildContext context, 
    String title, 
    Color color,
    VoidCallback onTap
  ) {
    return ListTile(
      title: Text(
        title, 
        style: TextStyle(color: color),
      ),
      onTap: onTap,
    );
  }



  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Implement logout logic
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).pop();
                // Navigate to login screen
              },
            ),
          ],
        );
      },
    );
  }
}