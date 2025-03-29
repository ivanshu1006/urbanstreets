import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/category_provider.dart';
import 'package:frappe_flutter_app/screens/home%20section/home_screen.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

final List<Map<String, String>> categories = [
  {"title": "Fitness", "image": "assets/images/fitness.png"},
  {"title": "Design", "image": "assets/images/design.png"},
  {"title": "Education", "image": "assets/images/education.png"},
  {"title": "Crafts", "image": "assets/images/crafts.png"},
  {"title": "Food", "image": "assets/images/food.png"},
  {"title": "Beauty", "image": "assets/images/beauty.png"},
  {"title": "Cars", "image": "assets/images/beauty.png"},
  {"title": "Travel", "image": "assets/images/travel.png"},
];

class InterstScreen extends StatelessWidget {
  const InterstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 50.h, top: 4.h),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.accentBlueColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upload photo section
                      const Text(
                        'Choose your interests',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.h),

                      SizedBox(
                        height: 380.h,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 17,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) {
                            return Consumer<CategoryProvider>(
                              builder: (context, categoryProvider, child) {
                                final category = categories[index]["title"]!;
                                final imagePath = categories[index]["image"]!;
                                final isSelected = categoryProvider
                                    .selectedCategories
                                    .contains(category);

                                return GestureDetector(
                                  onTap: () =>
                                      categoryProvider.toggleCategory(category),
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            ClipOval(
                                              child: Opacity(
                                                opacity: isSelected
                                                    ? 0.4
                                                    : 1.0,
                                                child: Image.asset(
                                                  imagePath,
                                                  width: 80.w,
                                                  height: 70.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            if (isSelected)
                                              Icon(
                                                Icons.check,
                                                size: 40.sp,
                                                color: Colors.black,
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 15.h),
                                        Text(
                                          category,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomElevatedButton(
                            label: 'Next',
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) =>  const HomeScreen()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 60.h, 40.w, 0),
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
}

// For handling location permission errors
class LocationErrorHandler {
  static void showLocationError(BuildContext context, String message) {
    SnackbarGlobal.show(message);
  }
}
