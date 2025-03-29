import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/providers/theme_provider.dart';
import 'package:frappe_flutter_app/utilities/common_utilities.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          _buildAppBar('Settings'),
          _buildSettingsItem(context, 'Profile Information', () {
            // Navigate to profile information screen
          }),
          _buildSettingsItem(context, 'Name, Location & personal details', () {
            // Navigate to profile information screen
          }),
          _buildSettingsItem(context, 'Language', () {
            // Navigate to language selection screen
          }),
          _buildSettingsItem(context, 'Privacy', () {
            // Navigate to privacy settings screen
          }),
          Spacer(),
          _buildToggleItem(context, 'Dark Mode', themeProvider.isDarkMode,
              (bool value) {
            themeProvider.toggleTheme();
          }),
          _buildLogoutItem(context),
        ],
      ),
    );
   
  }

   Widget _buildAppBar(String title) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
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
      BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 14.sp)
      ),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right),
    );
  }

  Widget _buildToggleItem(BuildContext context, String title, bool value,
      ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return ListTile(
      title: Text(
        'Logout',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Theme.of(context).colorScheme.error),
      ),
      onTap: () {
        // Implement logout logic
        _showLogoutConfirmDialog(context);
      },
    );
  }

  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                // Implement actual logout logic
                Navigator.of(context).pop();
                // Navigate to login screen or perform logout
              },
            ),
          ],
        );
      },
    );
  }
}