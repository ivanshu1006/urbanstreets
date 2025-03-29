import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/helpers/profile_helper.dart';
import 'package:frappe_flutter_app/providers/post_provider.dart';
import 'package:frappe_flutter_app/screens/business_section/business_page.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/posts_list_widget.dart';
import 'package:frappe_flutter_app/screens/profile_section/create_community_screen.dart';
import 'package:frappe_flutter_app/screens/profile_section/kyc_screen.dart';
import 'package:frappe_flutter_app/screens/settings_section/profile_settings_screen.dart';
import 'package:frappe_flutter_app/screens/settings_section/settings_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';


class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String selectedTab = "Photos";
  final List<String> tabs = ["Photos", "Videos", "Writing", "Heatmap"];

  @override
  void initState() {
    super.initState();
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.fetchUserProfile();
  }

  @override
Widget build(BuildContext context) {
  final postProvider = Provider.of<PostProvider>(context);
  final userProfile = postProvider.userProfile;

  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen() ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child:  Icon(Icons.settings, size: 20.w),
                        ),
                      ),
                    ],
                  ),
                ),
                userProfile != null
                    ? GestureDetector(
                      onTap: (){
                        ProfileHelper.showProfilePictureDialog(context);
                      },
                      child: ProfileSection(
                          profileImage: userProfile.profilePicUrl.toString(),
                          name: "${userProfile.firstName} ${userProfile.lastName ?? "N/A"}",
                          bio: userProfile.bio ?? '',
                        ),
                    )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const SizedBox(height: 20),
                ActivitySection(
                  selectedTab: selectedTab,
                  tabs: tabs,
                  onTabSelected: (tab) {
                    setState(() {
                      selectedTab = tab;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildActionButtons(context),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
        body: PostListScreen(),
      ),
    ),
  );
}


  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // ProfileHelper.showEnhanceProfileBottomSheet(context);
                context.push(RouteConstants.premium);
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return CompanyProfileScreen();
                // }));
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Center(
                  child: Text(
                    "Enhance profile",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  CreateCommunityScreen();
                }));
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Center(
                  child: Text(
                    "Create community",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ),
           SizedBox(width: 4.w),
          GestureDetector(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  KYCScreen();
                }));
            },
            child: Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Center(
                  child: Text(
                    "KYC",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(FileConstants.profile),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Elina",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "8 days ago",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              FileConstants.urbanLogo,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, size: 22),
                  SizedBox(width: 12),
                  Icon(Icons.chat_bubble_outline, size: 22),
                  SizedBox(width: 12),
                  Icon(Icons.share_outlined, size: 22),
                ],
              ),
              Icon(Icons.bookmark_border, size: 22),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Joseph and 99 others",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: "Elina ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      "My recent trip to Paris was really amazing. Here is the some of the glimpses of Paris from the trip. Wha... ",
                ),
                TextSpan(
                  text: "more",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "View all 16 comments",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(FileConstants.profile),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Add a comment...",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(Icons.add_circle_outline, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// **Profile Section Widget**
class ProfileSection extends StatelessWidget {
  final String name;
  final String bio;
  final String profileImage;

  const ProfileSection({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(profileImage),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettingsScreen()));
                },
                child: Icon(
                            Icons.edit_outlined,
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
              ),

            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                bio,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}

/// **Activity Section Widget**
class ActivitySection extends StatelessWidget {
  final String selectedTab;
  final List<String> tabs;
  final Function(String) onTabSelected;

  const ActivitySection({
    Key? key,
    required this.selectedTab,
    required this.tabs,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Activity",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabs.map((tab) {
                bool isSelected = tab == selectedTab;
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () => onTabSelected(tab),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 217, 217, 217)),
                        color: isSelected ? AppColors.primaryColor : const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade700,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
