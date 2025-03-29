import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/utilities/utilities.dart';
import 'package:frappe_flutter_app/widgets/custom_elevated_button.dart';

class ProfileHelper {
  // Bottom Sheet for Enhance Profile
  static void showEnhanceProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'See your profile views',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'With Premium, you can see profile viewers form the past 365 days. Massage, follow, or connect with your viewers when you upgrade.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                   CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(FileConstants.travel), // Replace with actual image
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: 'Sanjay and ',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'millions of other members',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' use Premium',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(onPressed: (){}, label: "Try Premium for 0",width: 400.w,)
              ),
            ],
          ),
        );
      },
    );
  }
  

  // Profile Picture Dialog
  static void showProfilePictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogOption(
                  text: 'View your Profile',
                  onTap: () {
                    // Add navigation or action
                    Navigator.pop(context);
                  },
                ),
                _buildDialogOption(
                  text: 'Create Community',
                  onTap: () {
                    // Add navigation or action
                    Navigator.pop(context);
                  },
                ),
                _buildDialogOption(
                  text: 'Create business ads',
                  onTap: () {
                    // Add navigation or action
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper widget for bottom sheet options
  static Widget _buildBottomSheetOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  // Helper widget for dialog options
  static Widget _buildDialogOption({
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}