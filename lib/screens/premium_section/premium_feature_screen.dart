import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:go_router/go_router.dart';

class PremiumFeatureScreen extends StatelessWidget {
  const PremiumFeatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back_ios, size: 20.w),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Unlock Exclusive Features!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Background Curved Lines
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/curvelines.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Content
          Padding(
            padding:  EdgeInsets.only(top: 60.h,left: 20.w,right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Features Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What you are going to get in Premium Membership are:-',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureItem('Ad-Free Experience'),
                      _buildFeatureItem('Premium Stickers & Reactions'),
                      _buildFeatureItem(
                        'Get access to Heat Map',
                        subtext: 'Heat map shows top sales around you',
                      ),
                      _buildFeatureItem(
                        'Unlock Create Community Option',
                        subtext: 'you can create upto 3 communities',
                      ),
                      _buildFeatureItem(
                        'Increase Business page limit',
                        subtext:
                            'You can create upto 5 business pages with premium membership',
                      ),
                      _buildFeatureItem(
                        'Post Representation',
                        subtext:
                            'Get your posts viewed by greater number of audience',
                      ),
                      _buildFeatureItem(
                        'Premium Sale',
                        subtext:
                            'Get access to premium sales of the businesses and you will be notified before other users',
                      ),
                    ],
                  ),
                ),

                // Spacer
                const Spacer(),

                // Purchase Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomElevatedButton(onPressed: (){}, label: "PURCHASE NOW",width: 400.w,)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, {String? subtext}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtext != null)
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
