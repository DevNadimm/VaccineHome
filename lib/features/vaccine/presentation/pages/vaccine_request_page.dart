import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';

class VaccineRequestPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineRequestPage());

  const VaccineRequestPage({super.key});

  @override
  State<VaccineRequestPage> createState() => _VaccineRequestPageState();
}

class _VaccineRequestPageState extends State<VaccineRequestPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Request'),
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
              CustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone number',
                validationLabel: 'Phone number',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Address',
                controller: addressController,
                isRequired: true,
                hintText: 'Enter address',
                validationLabel: 'Address',
              ),
              const SizedBox(height: 24),
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
        const SnackBar(content: Text('Vaccine request submitted!')),
      );
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void clearFields() {
    addressController.clear();
    phoneController.clear();
  }
}
