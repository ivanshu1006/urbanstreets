import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frappe_flutter_app/screens/business_community_section/community_documents_screen.dart';
import 'package:frappe_flutter_app/screens/business_community_section/widgets/button.dart';
import 'package:frappe_flutter_app/theme/app_colors.dart';
import 'package:frappe_flutter_app/widgets/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';

class CommunityclaimScreen extends StatefulWidget {
  const CommunityclaimScreen({Key? key}) : super(key: key);

  @override
  _CommunityclaimScreenState createState() => _CommunityclaimScreenState();
}

class _CommunityclaimScreenState extends State<CommunityclaimScreen> {
  bool _isClaimBusiness = true;
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.w,color: AppColors.blackColor,),
          onPressed: () => context.pop(),
        ),
        title: Text('Business', style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor)),
      ),
      body: Column(
        children: [
          // Progress Indicator Slider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: LinearProgressIndicator(
              value: 0.25, // First step of 4 steps
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Business Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: CommunityButton(
                               height: 30.h,
                              width: 150.w,
                              label: 'Claim business',
                              onPressed: () => setState(() {
                                _isClaimBusiness = true;
                              }),
                              isSelected: _isClaimBusiness,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: CommunityButton(
                              height: 30.h,
                              width: 150.w,
                              label: 'Create business',
                              onPressed: () => setState(() {
                                _isClaimBusiness = false;
                              }),
                              isSelected: !_isClaimBusiness,
                            ),
                              // backgroundColor: !_isClaimBusiness
                              //     ? AppColors.primaryColor
                              //     : Colors.grey[300],
                              // labelColor: !_isClaimBusiness
                              //     ? Colors.white
                              //     : Colors.black,
                            ),
                          
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Dynamic Fields based on selected action
                      Text(
                        'Add Personal Details',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Enter the below details to create Community',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Conditional Fields
                      ..._buildDynamicFields(),

                      SizedBox(height: 24.h),

                      // Continue and Cancel Buttons
                      CustomElevatedButton(
                        width: 400.w,
                        label: 'Continue',
                        onPressed: _onContinue,
                      ),
                      SizedBox(height: 16.h),
                      CustomElevatedButton(
                        width: 400.w,
                        isPrimary: true,
                        label: 'Cancel',
                        onPressed: _onContinue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDynamicFields() {
    return _isClaimBusiness
        ? [
            _buildTextField('Name', _nameController),
            SizedBox(height: 16.h),
            _buildTextField('Mobile Number', _mobileController,
                keyboardType: TextInputType.phone),
            SizedBox(height: 16.h),
            _buildTextField('Address', _addressController, maxLines: 3),
          ]
        : [
            _buildTextField('Name', _nameController),
            SizedBox(height: 16.h),
            _buildTextField('Mobile Number', _mobileController,
                keyboardType: TextInputType.phone),
            SizedBox(height: 16.h),
            _buildTextField('Business Name', _businessNameController),
            SizedBox(height: 16.h),
            _buildTextField('Address', _addressController, maxLines: 3),
          ];
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hint';
        }
        return null;
      },
    );
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement navigation to next screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityDocumentsScreen()));
      print('Form is valid');
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _businessNameController.dispose();
    super.dispose();
  }
}
