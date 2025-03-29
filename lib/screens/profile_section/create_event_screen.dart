import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/providers/profile_provider.dart';
import 'package:frappe_flutter_app/screens/profile_section/widgets/event_type_selector_dropdown.dart';
import 'package:frappe_flutter_app/screens/profile_section/widgets/speaker_input_section.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  late TextEditingController _titleController;
  late TextEditingController _overviewController;
  late TextEditingController _venueController;
  late TextEditingController _entryFeeController;
  List<String> _speakers = [];
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _overviewController = TextEditingController();
    _venueController = TextEditingController();
    _entryFeeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _overviewController.dispose();
    _venueController.dispose();
    _entryFeeController.dispose();
    super.dispose();
  }

  void _addSpeaker(String speaker) {
    setState(() {
      _speakers.add(speaker);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.w),
          onPressed: () =>context.pop(),
        ),
        title: Text(
          'Create event',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Cover Image Placeholder
              Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18.r,
                      child: Icon(
                        Icons.edit,
                        size: 20.w,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Event Title Input
              Text(
                'Football game event',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 16.h),

              // Event Type Section
              const EventFormSection(
                title: 'Event type',
                child: EventTypeSelector(),
              ),

              SizedBox(height: 16.h),

              // Overview Section
              EventFormSection(
                title: 'Overview',
                child: TextFormField(
                  controller: _overviewController,
                  decoration: InputDecoration(
                    hintText: 'Enter event overview',
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 16.sp),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Event Speakers Section
              EventFormSection(
                title: 'Event speakers',
                child: Column(
                  children: [
                    const SpeakersInputSection(),
                    SizedBox(height: 8.h),
                    const SpeakersInputSection(),
                    SizedBox(height: 8.h),
                    const SpeakersInputSection(),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              Divider(thickness: 1.h, color: Colors.grey[200]),

              SizedBox(height: 16.h),

              // Event Timing Section
              EventFormSection(
                title: 'Event timing',
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _startDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Text(
                              _startDate?.toString().split(' ')[0] ??
                                  'Select start date',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'to',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _endDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Center(
                            child: Text(
                              _endDate?.toString().split(' ')[0] ??
                                  'Select end date',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Entry Fee Section
              EventFormSection(
                title: 'Entry fee',
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _entryFeeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter entry fee',
                          hintStyle: TextStyle(
                              color: Colors.grey[400], fontSize: 16.sp),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '\$',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Event Venue Section
              EventFormSection(
                title: 'Event Venue',
                child: TextFormField(
                  controller: _venueController,
                  decoration: InputDecoration(
                    hintText: 'Enter event venue',
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 16.sp),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () async {
                        final profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false);

                        try {
                          await profileProvider.createEvent(
                            communityId: 6,
                            title: _titleController.text,
                            description: _overviewController.text,
                            coverBannerUrl:
                                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.alamy.com%2Fstock-photo%2Fglobe-of-network.html&psig=AOvVaw3rmf6hvGpkwZPCuv58eX9-&ust=1742988427478000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCOD7j4KQpYwDFQAAAAAdAAAAABAJ', // Replace with actual image upload logic
                            date: _startDate!.toIso8601String().split('T')[0],
                            time: _startDate!
                                .toIso8601String()
                                .split('T')[1]
                                .split('.')[0],
                            speakers: _speakers,
                            entryFee: double.parse(_entryFeeController.text),
                          );

                          SnackbarGlobal.show('Event created successfully');
                          context.pop();
                        } catch (e) {
                          SnackbarGlobal.show(e.toString());
                        }
                      },
                      label: "Create",
                      width: 200.w,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                      child: CustomElevatedButton(
                    onPressed: () {},
                    label: "Cancel",
                    width: 200.w,
                    isPrimary: true,
                  )),
                ],
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Components

class EventFormSection extends StatelessWidget {
  final String title;
  final Widget child;

  const EventFormSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.accentBlueColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          child,
        ],
      ),
    );
  }
}


