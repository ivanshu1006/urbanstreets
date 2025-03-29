import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/profile_provider.dart';
import 'package:frappe_flutter_app/screens/home%20section/widgets/posts_list_widget.dart';
import 'package:frappe_flutter_app/screens/profile_section/create_event_screen.dart';
import 'package:frappe_flutter_app/screens/profile_section/regsiter_event_screen.dart';
import 'package:frappe_flutter_app/theme/theme.dart';
import 'package:go_router/go_router.dart';

class GameMeetupApp extends StatefulWidget {
  const GameMeetupApp({super.key});

  @override
  State<GameMeetupApp> createState() => _GameMeetupAppState();
}

class _GameMeetupAppState extends State<GameMeetupApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

@override
void initState() {
  super.initState();
  _tabController = TabController(length: 4, vsync: this);
  _tabController.addListener(() {
    setState(() {
      _selectedIndex = _tabController.index;
    });

    // Fetch events when the "Event" tab is selected
    if (_tabController.index == 2) {
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.fetchEvents();
    }
  });
}
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToRegister(BuildContext context, String eventName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(eventName: eventName, event: Event(id: "D", title: "title", description: "description", date: "date", speakers: []),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _getSelectedScreen(),
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildAboutTab();
      case 1:
        return _buildFeedTab();
      case 2:
        return _buildEventTab();
      case 3:
        return _buildMembersTab();
      default:
        return _buildAboutTab();
    }
  }

  Widget _buildAboutTab() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar('About'),
          
          // Grey Banner Image Area
          _buildBannerWithEdit(),
          
          // Group Title
          _buildGroupTitle(),
          
          // Members and Location
          _buildMemberInfo(),
          
          const SizedBox(height: 24),
          
          // Tab Bar
          _buildTabBar(),
          
          // About Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '"Surat Game Meetup is a community for gamers, developers, and esports enthusiasts to connect, share, and compete!"',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _detailRow('Members:', '10'),
                  const SizedBox(height: 12),
                  _detailRow('Created at:', '2024'),
                  const SizedBox(height: 12),
                  _detailRow('Category:', 'Sports'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar('Feed'),
          
          // Group Title
          _buildGroupTitle(),
          
          // Tab Bar
          _buildTabBar(),
          
          // Create Post Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 16,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Add your post',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.image, color: Colors.grey.shade600),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Feed Posts
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                 PostListScreen()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildEventTab() {
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAppBar('Event'),
        // Banner with Edit
        _buildBannerWithEdit(),
        // Group Title
        _buildGroupTitle(),
        // Member Info and Action Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '5 Member',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    'New York, Public Group',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Create Post and Event Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Create post'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEventScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Create event'),
                ),
              ),
            ],
          ),
        ),
        // Tab Bar
        _buildTabBar(),
        // Upcoming Events Title
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        // Events List
        Expanded(
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              if (profileProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (profileProvider.events.isEmpty) {
                return const Center(child: Text('No upcoming events'));
              }

              return SingleChildScrollView(
                child: Column(
                  children: profileProvider.events.map((event) {
                    return EventCard(
                      title: event['title'],
                      date: event['date'],
                      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      speakers: [], // You can add speaker data if available in the API
                      onRegister: () => _navigateToRegister(context, event['title']),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _buildMembersTab() {
    // Placeholder for the Members tab
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar('Members'),
          _buildGroupTitle(),
          _buildTabBar(),
          const Expanded(
            child: Center(
              child: Text('Members Content'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(String title) {
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

  Widget _buildBannerWithEdit() {
    return Container(
      width: double.infinity,
      height: 130,
      color: Colors.grey.shade300,
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildGroupTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Text(
        'Surat game meetup',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMemberInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '5 Member',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'New York, Public Group',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'About'),
        Tab(text: 'Feed'),
        Tab(text: 'Event'),
        Tab(text: 'Members'),
      ],
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blue,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildPostCard({
    required String username,
    required bool isHost,
    required String postText,
    required int likes,
    required int comments,
    bool hasImage = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(username: username, isHost: isHost),
        if (hasImage)
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey.shade300,
            child: Image.asset(FileConstants.urbanLogo)
            // Image.network(
            //   '/api/placeholder/400/320',
            //   fit: BoxFit.cover,
            // ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              Icon(Icons.thumb_up_outlined, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Icon(Icons.chat_bubble_outline, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Icon(Icons.share, color: Colors.grey.shade700),
              const Spacer(),
              const Icon(Icons.bookmark_border),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                '$username and $likes others',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: 'Elina ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: postText),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            children: [
              Text(
                'View all $comments comments',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: Colors.grey.shade300, radius: 16),
              const SizedBox(width: 12),
              Text(
                'Add a comment...',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const Spacer(),
              Icon(Icons.add_circle_outline, color: Colors.grey.shade600),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostHeader({required String username, required bool isHost}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Colors.grey.shade300, radius: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              if (isHost)
                Text(
                  'Host',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// Reusable Event Card Component
class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final List<Speaker> speakers;
  final String? eventType;
  final String? eventVenue;
  final VoidCallback onRegister;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.speakers,
    this.eventType,
    this.eventVenue,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.accentBlueColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Event speakers',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          // Speaker avatars with names
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: speakers.map((speaker) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 16,
                    ),
                    const SizedBox(width: 4),
                    Text('${speaker?.id!}. ${speaker.name}'),
                    const SizedBox(width: 8),
                  ],
                );
              }).toList(),
            ),
          ),
          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(description),
          ),
          // Additional details if provided
          if (eventType != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Text('Event type : $eventType'),
            ),
          if (eventVenue != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
              child: Text('Event Venue : $eventVenue'),
            ),
          // Register button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(left: 160.w,bottom: 10.h),
              child: CustomElevatedButton(onPressed: onRegister, label: 'Register',height: 25.h,width: 100.w,)
            ),
          ),
        ],
      ),
    );
  }
}
// Speaker class to manage speaker data
class Speaker {
  final String id;
  final String name;
  final String imageUrl;

  Speaker({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

// Event class to manage event data
class Event {
  final String id;
  final String title;
  final String description;
  final String date;
  final List<Speaker> speakers;
  final String? eventType;
  final String? venue;
  final String? timing;
  final String? entryFee;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.speakers,
    this.eventType,
    this.venue,
    this.timing,
    this.entryFee,
  });
}


// Code for the Events tab showing the list of events
class EventsTab extends StatelessWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Event> events = [
      Event(
        id: '1',
        title: 'Football game event',
        description: 'Football is a team sport where players score goals to win. It\'s played in two 45-minute halves.',
        date: '23rd Jan',
        speakers: [
          Speaker(id: '1', name: 'Henry', imageUrl: 'assets/speakers/henry.jpg'),
          Speaker(id: '2', name: 'John', imageUrl: 'assets/speakers/john.jpg'),
          Speaker(id: '3', name: 'Alex', imageUrl: 'assets/speakers/alex.jpg'),
        ],
        timing: '10 : 00 am to 2 :00 pm',
        entryFee: '500\$',
      ),
      Event(
        id: '2',
        title: 'Food event',
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        date: '23rd Jan',
        speakers: [
          Speaker(id: '1', name: 'Henry', imageUrl: 'assets/speakers/henry.jpg'),
          Speaker(id: '4', name: 'Jack', imageUrl: 'assets/speakers/jack.jpg'),
          Speaker(id: '5', name: 'Lisa', imageUrl: 'assets/speakers/lisa.jpg'),
        ],
        eventType: 'Offline',
        venue: 'Vadodara',
      ),
    ];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Bar with Back Button
          Padding(
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
                const Text(
                  'Event',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          
          // Grey Banner Image Area
          Container(
            width: double.infinity,
            height: 130,
            color: Colors.grey.shade300,
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          
          // Group Title and Members
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Text(
              'Surat game meetup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5 Member',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'New York, Public Group',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                // Create Post Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Create post'),
                ),
                const SizedBox(width: 10),
                // Create Event Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Create event'),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Tab Bar
          const TabBar(
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Feed'),
              Tab(text: 'Event'),
              Tab(text: 'Members'),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          
          const SizedBox(height: 16),
          
          // Upcoming Events Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return _buildEventCard(context, event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  event.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Event speakers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: event.speakers.asMap().entries.map((entry) {
                int idx = entry.key;
                Speaker speaker = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade300,
                        // You would use NetworkImage or AssetImage here
                        // backgroundImage: AssetImage(speaker.imageUrl),
                      ),
                      const SizedBox(width: 4),
                      Text('${idx + 1}. ${speaker.name}'),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              event.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            if (event.eventType != null || event.venue != null) ...[
              const SizedBox(height: 12),
              if (event.eventType != null)
                Text(
                  'Event type : ${event.eventType}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              if (event.venue != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Event Venue : ${event.venue}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ],
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(event: event, eventName: '',),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}