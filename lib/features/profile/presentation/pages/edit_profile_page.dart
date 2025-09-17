import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/row_fields.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/upload_avatar_section.dart';

class EditProfilePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const EditProfilePage());

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController address = TextEditingController();
  File? avatar;

  @override
  void initState() {
    _getPreferences();
    super.initState();
  }

  Future<void> _getPreferences () async {
    name.text = await AppPreferences.getUserName() ?? '';
    email.text = await AppPreferences.getUserEmail() ?? '';
    phone.text = await AppPreferences.getUserPhone() ?? '';
  }

  Future<void> _selectOnlyDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UploadProfileImageSection(
                imageFile: avatar,
                onImagePicked: (image) => setState(() => avatar = image),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Name',
                controller: name,
                isRequired: true,
                keyboardType: TextInputType.name,
                hintText: 'Enter name',
                validationLabel: 'Name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                controller: email,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter email',
                validationLabel: 'Email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone',
                controller: phone,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone',
                validationLabel: 'Phone',
              ),
              const SizedBox(height: 16),
              RowFields(
                firstField: CustomTextField(
                  label: 'Date of Birth',
                  controller: dateOfBirth,
                  isRequired: false,
                  keyboardType: TextInputType.datetime,
                  hintText: 'Select date',
                  validationLabel: 'Date of Birth',
                  readOnly: true,
                  onTap: () => _selectOnlyDate(dateOfBirth),
                ),
                lastField: CustomTextField(
                  label: 'Gender',
                  controller: gender,
                  isRequired: false,
                  hintText: 'Select gender',
                  validationLabel: 'Gender',
                  readOnly: true,
                  onTap: () {
                    showCustomBottomSheet(
                      context: context,
                      items: ['Male', 'Female', 'Others'],
                      controller: gender,
                      title: 'Select Gender',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Address',
                controller: address,
                isRequired: false,
                keyboardType: TextInputType.streetAddress,
                hintText: 'Enter address',
                validationLabel: 'Address',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _editProfile,
                  child: const Text(
                    'Save Profile',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() async {
    if (globalKey.currentState?.validate() ?? false) {
      final dioService = serviceLocator<DioService>();
      Map<String, dynamic> data = {'_method': 'PUT'};

      if (avatar != null) {
        await dioService.postMultipart(
          'profile',
          file: avatar!,
          fileFieldName: 'avatar',
          data: data,
        );
      } else {
        await dioService.putRequest('profile', data: data);
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    gender.dispose();
    dateOfBirth.dispose();
    address.dispose();
    super.dispose();
  }
}
