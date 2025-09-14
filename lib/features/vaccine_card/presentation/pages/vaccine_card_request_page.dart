import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';

class VaccineCardRequestPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineCardRequestPage());

  const VaccineCardRequestPage({super.key});

  @override
  State<VaccineCardRequestPage> createState() => _VaccineCardRequestPageState();
}

class _VaccineCardRequestPageState extends State<VaccineCardRequestPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();

  // Personal Info
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController fatherName = TextEditingController();
  final TextEditingController matherName = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController nationality = TextEditingController();

  // Identity Docs
  final TextEditingController birthCertificateNo = TextEditingController();
  final TextEditingController passportNo = TextEditingController();

  // Contact Info
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController whatsAppImo = TextEditingController();
  final TextEditingController address = TextEditingController();

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
        title: const Text('Vaccine Card Request'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Info
              RowFields(
                firstField: CustomTextField(
                  label: 'First Name',
                  controller: firstName,
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  hintText: 'Enter first name',
                  validationLabel: 'First Name',
                ),
                lastField: CustomTextField(
                  label: 'Last Name',
                  controller: lastName,
                  isRequired: true,
                  keyboardType: TextInputType.name,
                  hintText: 'Enter last name',
                  validationLabel: 'Last Name',
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Father Name',
                controller: fatherName,
                isRequired: true,
                keyboardType: TextInputType.name,
                hintText: 'Enter father name',
                validationLabel: 'Father Name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Mother Name',
                controller: matherName,
                isRequired: true,
                keyboardType: TextInputType.name,
                hintText: 'Enter mother name',
                validationLabel: 'Mother Name',
              ),
              const SizedBox(height: 16),
              RowFields(
                firstField: CustomTextField(
                  label: 'Date of Birth',
                  controller: dateOfBirth,
                  isRequired: true,
                  keyboardType: TextInputType.datetime,
                  hintText: 'Select date',
                  validationLabel: 'Date of Birth',
                  readOnly: true,
                  onTap: () => _selectOnlyDate(dateOfBirth),
                ),
                lastField: CustomTextField(
                  label: 'Gender',
                  controller: gender,
                  isRequired: true,
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
                label: 'Nationality',
                controller: nationality,
                isRequired: true,
                hintText: 'Enter nationality',
                validationLabel: 'Nationality',
              ),
              const SizedBox(height: 24),

              // Identity Docs
              CustomTextField(
                label: 'Birth Certificate No',
                controller: birthCertificateNo,
                isRequired: true,
                keyboardType: TextInputType.number,
                hintText: 'Enter birth certificate number',
                validationLabel: 'Birth Certificate No',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Passport No',
                controller: passportNo,
                isRequired: false,
                keyboardType: TextInputType.number,
                hintText: 'Enter passport number',
                validationLabel: 'Passport No',
              ),
              const SizedBox(height: 24),

              // Contact Info
              CustomTextField(
                label: 'Email',
                controller: email,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter email address',
                validationLabel: 'Email',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone Number',
                controller: phoneNumber,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone number',
                validationLabel: 'Phone Number',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'WhatsApp / Imo',
                controller: whatsAppImo,
                isRequired: false,
                keyboardType: TextInputType.phone,
                hintText: 'Enter WhatsApp or Imo number',
                validationLabel: 'WhatsApp/Imo',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Address',
                controller: address,
                isRequired: true,
                keyboardType: TextInputType.streetAddress,
                hintText: 'Enter address',
                validationLabel: 'Address',
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  child: const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (globalKey.currentState?.validate() ?? false) {
      clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vaccine card request submitted!')),
      );
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    fatherName.dispose();
    matherName.dispose();
    dateOfBirth.dispose();
    gender.dispose();
    nationality.dispose();
    birthCertificateNo.dispose();
    passportNo.dispose();
    email.dispose();
    phoneNumber.dispose();
    whatsAppImo.dispose();
    address.dispose();
    super.dispose();
  }

  void clearFields() {
    firstName.clear();
    lastName.clear();
    fatherName.clear();
    matherName.clear();
    dateOfBirth.clear();
    gender.clear();
    nationality.clear();
    birthCertificateNo.clear();
    passportNo.clear();
    email.clear();
    phoneNumber.clear();
    whatsAppImo.clear();
    address.clear();
  }
}

class RowFields extends StatelessWidget {
  final Widget firstField;
  final Widget lastField;

  const RowFields({
    super.key,
    required this.firstField,
    required this.lastField,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: firstField),
        const SizedBox(width: 10),
        Expanded(child: lastField),
      ],
    );
  }
}
