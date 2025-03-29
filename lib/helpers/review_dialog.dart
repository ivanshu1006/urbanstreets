import 'package:flutter/material.dart';

class MoreOptionsDialog {
  // Static method to show the more options dialog
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildOptionItem(context, 'Videos', Icons.video_library),
                _buildOptionItem(context, 'Live', Icons.live_tv),
                _buildOptionItem(context, 'Followers', Icons.people),
                _buildOptionItem(context, 'Check-ins', Icons.check_circle),
                _buildOptionItem(context, 'Music', Icons.music_note),
                _buildOptionItem(context, 'Reviews given', Icons.reviews),
                _buildOptionItem(context, 'Likes', Icons.favorite),
                _buildOptionItem(context, 'Search', Icons.search),
                _buildOptionItem(context, 'Report Page', Icons.report_problem),
                _buildOptionItem(context, 'Block', Icons.block),
                _buildOptionItem(context, 'Invite friends', Icons.person_add),
                _buildOptionItem(context, 'Follow', Icons.add_circle),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to create consistent menu items
  static Widget _buildOptionItem(
    BuildContext context, 
    String text, 
    IconData icon
  ) {
    return InkWell(
      onTap: () {
        // Add specific action for each menu item
        Navigator.pop(context);
        // You can add specific logic for each menu item here
        _handleMenuAction(text);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Handle specific actions for menu items
  static void _handleMenuAction(String action) {
    // Placeholder for specific action handling
    print('Selected action: $action');
    // You can add specific navigation or action logic here
  }
}

// Example usage in a widget
class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => MoreOptionsDialog.show(context),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Show More Options'),
          onPressed: () => MoreOptionsDialog.show(context),
        ),
      ),
    );
  }
}