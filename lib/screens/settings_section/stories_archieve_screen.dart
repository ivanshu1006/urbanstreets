import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/model/story_posts_models/story_post_model.dart';
import 'package:frappe_flutter_app/providers/location_provider.dart';
import 'package:frappe_flutter_app/providers/stories_archieve_provider.dart';
import 'package:frappe_flutter_app/screens/settings_section/widgets/calendar.dart';
import 'package:frappe_flutter_app/screens/settings_section/widgets/story_post_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class StoriesArchiveScreen extends StatelessWidget {
  const StoriesArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoriesArchiveProvider(),
      child: Scaffold(
       
        body: Column(
          children: [
            _buildAppBar("Stories Archieve",context),
            // Top Navigation Section
            _buildTopNavigation(context),
            
            // Content Based on Selected View
            Expanded(
              child: Consumer<StoriesArchiveProvider>(
                builder: (context, provider, child) {
                  switch (provider.currentView) {
                    case StoriesArchiveViewType.posts:
                      return _buildPostsView();
                    case StoriesArchiveViewType.calendar:
                      return _buildCalendarView();
                    case StoriesArchiveViewType.location:
                      return _buildLocationView(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigation(BuildContext context) {
    return Consumer<StoriesArchiveProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context, 
              icon: Icons.grid_on,
              isSelected: provider.currentView == StoriesArchiveViewType.posts,
              onTap: () => provider.changeView(StoriesArchiveViewType.posts),
            ),
            _buildNavItem(
              context, 
              icon: Icons.calendar_today,
              isSelected: provider.currentView == StoriesArchiveViewType.calendar,
              onTap: () => provider.changeView(StoriesArchiveViewType.calendar),
            ),
            _buildNavItem(
              context, 
              icon: Icons.location_on,
              isSelected: provider.currentView == StoriesArchiveViewType.location,
              onTap: () => provider.changeView(StoriesArchiveViewType.location),
            ),
          ],
        );
      },
    );
  }

   Widget _buildAppBar(String title,BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
         Icon(Icons.more_vert)
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected 
          ? Theme.of(context).primaryColor 
          : Colors.grey,
      ),
      onPressed: onTap,
    );
  }

  Widget _buildPostsView() {
    // Sample data - replace with actual API call
    final posts = [
      StoryPostModel(imageUrl: FileConstants.cover, date: '9 Nov'),
      StoryPostModel(imageUrl: FileConstants.cover, date: '10 Nov'),
      StoryPostModel(imageUrl: FileConstants.cover, date: '11 Nov'),
      // Add more posts...
    ];

    return GridView.builder(
      padding: EdgeInsets.all(2.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.w,
        mainAxisSpacing: 2.h,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return StoryPostWidget(post: posts[index]);
      },
    );
  }

  Widget _buildCalendarView() {
    return const StoriesArchiveCalendar();
  }

 Widget _buildLocationView(BuildContext context) {
    // Use Consumer to access LocationProvider
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Expanded(
          child: FlutterMap(
            mapController: locationProvider.mapController,
            options: MapOptions(
              initialCenter: locationProvider.selectedLocation ?? const LatLng(0, 0),
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 3.0,
              onTap: locationProvider.onMapTapped,
              onMapReady: locationProvider.initMapController,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  if (locationProvider.selectedLocation != null)
                    Marker(
                      width: 40.w,
                      height: 40.h,
                      point: locationProvider.selectedLocation!,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
