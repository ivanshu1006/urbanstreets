import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeakersInputSection extends StatefulWidget {
  const SpeakersInputSection({super.key});

  @override
  _SpeakersInputSectionState createState() => _SpeakersInputSectionState();
}

class _SpeakersInputSectionState extends State<SpeakersInputSection> {
  List<TextEditingController> speakerControllers = [];

  void _addSpeakerField() {
    if (speakerControllers.length < 3) {
      setState(() {
        speakerControllers.add(TextEditingController());
      });
    }
  }

  @override
  void dispose() {
    for (var controller in speakerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (speakerControllers.isEmpty)
          _buildAddButton()
        else
          Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: speakerControllers.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  return Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: speakerControllers[index],
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
              if (speakerControllers.length < 3)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: _buildAddButton(),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: speakerControllers.length < 3 ? _addSpeakerField : null,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: speakerControllers.length < 3 ? Colors.blue : Colors.grey,
            size: 20.w,
          ),
        ),
      ),
    );
  }
}