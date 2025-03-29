import 'package:frappe_flutter_app/core/barrel_file.dart';

class EventTypeSelector extends StatefulWidget {
  const EventTypeSelector({super.key});

  @override
  _EventTypeSelectorState createState() => _EventTypeSelectorState();
}

class _EventTypeSelectorState extends State<EventTypeSelector> {
  List<String> eventTypes = ['Offline', 'Online'];
  String selectedEventType = 'Offline';
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropdownOpen = !isDropdownOpen;
        });
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.r),
                topRight: Radius.circular(4.r),
                bottomLeft: Radius.circular(isDropdownOpen ? 0 : 4.r),
                bottomRight: Radius.circular(isDropdownOpen ? 0 : 4.r),
              ),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedEventType,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  isDropdownOpen 
                    ? Icons.keyboard_arrow_up 
                    : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                  size: 24.w,
                ),
              ],
            ),
          ),
          if (isDropdownOpen)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4.r),
                  bottomRight: Radius.circular(4.r),
                ),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1.w,
                ),
              ),
              child: Column(
                children: eventTypes
                    .where((type) => type != selectedEventType)
                    .map((type) => _buildDropdownItem(type))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEventType = type;
          isDropdownOpen = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w, 
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 1.w,
            ),
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}