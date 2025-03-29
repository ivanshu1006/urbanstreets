import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/helpers/review_dialog.dart';
import 'package:frappe_flutter_app/screens/business_section/widgets/about_widget.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/posts_list_widget.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';

class CompanyProfileScreen extends StatefulWidget {
  @override
  _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const PostListScreen(), // Your PostListScreen widget
    const CompanyAboutWidget(
        companyName: "companyName",
        address: "address",
        mobile: "mobile",
        email: "email",
        website: "website",
        category: "category"),
    SocialMediaPostWidget(),
    RatingWidget(
        userName: "userName",
        profileImageUrl: "profileImageUrl",
        postTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage(FileConstants.cover), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                left: 16,
                bottom: 16,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/logo.png'), 
                ),
              ),
              const Positioned(
                left: 110,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'likes followers',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 140,
                // right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    _buildButton('Call Now'),
                    const SizedBox(width: 8),
                    _buildButton('Message'),
                    const SizedBox(width: 8),
                    _buildButton('Campaign'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildTabBar(),
          Expanded(
            child: _tabs[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 2.w,
              ),
              _buildTabItem(0, 'Post'),
              _buildTabItem(1, 'About'),
              _buildTabItem(2, 'Mentions'),
              _buildTabItem(3, 'Reviews'),
            ],
          ),
          GestureDetector(
            onTap: () {
              MoreOptionsDialog.show(context);
            },
            child: Image.asset(
              FileConstants.threedots,
              height: 10.h,
              width: 20.w,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight:
                  _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          if (_selectedIndex == index)
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              height: 5,
              width: 50,
            ),
        ],
      ),
    );
  }
}

class SocialMediaPostWidget extends StatefulWidget {
  @override
  State<SocialMediaPostWidget> createState() => _SocialMediaPostWidgetState();
}

class _SocialMediaPostWidgetState extends State<SocialMediaPostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile icon
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Image.asset(
                    FileConstants.profile, // Replace with your asset path
                    height: 20.h,
                  ),
                ),
                const SizedBox(width: 12),
                // Write something text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(4.h),
                      height: 40.0,
                      width: 280.0,
                      decoration: BoxDecoration(
                        color: AppColors
                            .accentBlueColor, // Replace with your color
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: TextField(
                          style: TextStyle(
                            color: AppColors.accentBlueColor,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Write something...',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        _buildActionButton(
                          icon: FileConstants.attachments,
                          label: 'Photo / Video',
                          color: AppColors.blackColor,
                        ),
                        SizedBox(width: 12.w),
                        _buildActionButton(
                          icon: FileConstants.profile,
                          label: 'Tag people',
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 137, 137, 137)
                              .withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mentions',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.accentBlueColor),
                            child: const Center(child: Text("Sort")),
                          )
                        ],
                      ),
                    ),

                    // Sort Button
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to create action buttons
  Widget _buildActionButton({
    required String icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Image.asset(icon, color: color, height: 16.h),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class RatingWidget extends StatelessWidget {
  // Data parameters
  final String userName;
  final String profileImageUrl;
  final DateTime postTime;

  // Optional customization parameters
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onRating;
  final VoidCallback? onShare;

  const RatingWidget({
    Key? key,
    required this.userName,
    required this.profileImageUrl,
    required this.postTime,
    this.onLike,
    this.onComment,
    this.onRating,
    this.onShare,
  }) : super(key: key);

  // Helper method to format time difference
  String _formatTimeAgo(DateTime postTime) {
    final now = DateTime.now();
    final difference = now.difference(postTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 92, 92, 93).withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 5),
            ),
          ],
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatTimeAgo(postTime),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Comment Input
            SizedBox(
              height: 14.h,
            ),
            Divider(
              height: 1,
              color: AppColors.selectedButtonColor,
            ),
            SizedBox(
              height: 14.h,
            ),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                    icon: FileConstants.link, onPressed: onLike, label: "Like"),
                _buildActionButton(
                    icon: FileConstants.profile,
                    onPressed: onComment,
                    label: "Comment"),
                _buildActionButton(
                    icon: FileConstants.profile,
                    onPressed: onRating,
                    label: "Rating"),
                _buildActionButton(
                    icon: FileConstants.profile,
                    onPressed: onShare,
                    label: "Share"),
              ],
            ),

            // Comment Input
            SizedBox(
              height: 14.h,
            ),
            Divider(
              height: 1,
              color: AppColors.selectedButtonColor,
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.accentBlueColor,
                  child: Image.asset(
                    FileConstants.profile,
                    height: 20.h,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Container(
                  width: 260.w,
                  height: 30.h,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write Comment',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          // Implement comment submission logic
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.accentBlueColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    VoidCallback? onPressed,
  }) {
    return Row(
      children: [
        InkWell(
            onTap: onPressed,
            child: Image.asset(
              icon,
              height: 20.h,
            )),
        SizedBox(
          width: 4.w,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp),
        )
      ],
    );
  }
}

// import 'package:frappe_flutter_app/core/barrel_file.dart';
// import 'package:frappe_flutter_app/screens/business_section/widgets/about_widget.dart';
// import 'package:frappe_flutter_app/screens/home%20section/widgets/posts_list_widget.dart';

// class CompanyProfileScreen extends StatefulWidget {
//   @override
//   _CompanyProfileScreenState createState() => _CompanyProfileScreenState();
// }

// class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
//   int _selectedIndex = 0;
//   final List<Widget> _tabs = [
//     const Center(child: PostList()),
//     Center(child: CompanyAboutWidget(companyName: "companyName", address: "address", mobile: "mobile", email: "email", website: "website", category: "category")),
//     Center(child: Text('Mentions Section')),
//     Center(child: Text('Reviews Section')),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(FileConstants.cover), // Add your cover image
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 16,
//                 bottom: 16,
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage(FileConstants.profile), // Add your company logo
//                 ),
//               ),
//               Positioned(
//                 top:110,
//                 left: 120,
//                 bottom: 30,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Company Name',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'likes followers',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 160,
//                 right: 10,
//                 bottom: 16,
//                 child: Row(
//                   children: [
//                     _buildButton('Call Now'),
//                     SizedBox(width: 8),
//                     _buildButton('Message'),
//                     SizedBox(width: 8),
//                     _buildButton('Campaign'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           _buildTabBar(),
//           Expanded(
//             child: _tabs[_selectedIndex],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton(String text) {
//     return CustomElevatedButton(onPressed: (){}, label: text,height: 20.h,
//       width: 70.w,);
//   }

//   Widget _buildTabBar() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildTabItem(0, 'Post'),
//         _buildTabItem(1, 'About'),
//         _buildTabItem(2, 'Mentions'),
//         _buildTabItem(3, 'Reviews'),
//       ],
//     );
//   }

//   Widget _buildTabItem(int index, String text) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//       child: Column(
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           SizedBox(height: 4),
//           if (_selectedIndex == index)
//             Container(
//               height: 3,
//               width: 40,
//               color: Colors.blue,
//             ),
//         ],
//       ),
//     );
//   }
// }
