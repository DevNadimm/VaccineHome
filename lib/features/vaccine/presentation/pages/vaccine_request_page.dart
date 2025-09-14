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
  final TextEditingController divisionNameController = TextEditingController();
  final TextEditingController divisionIdController = TextEditingController();
  final TextEditingController policeStationNameController = TextEditingController();
  final TextEditingController policeStationIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productIdController = TextEditingController();
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
                label: 'Division',
                controller: divisionNameController,
                isRequired: true,
                hintText: 'Enter division',
                validationLabel: 'Division',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Police Station',
                controller: policeStationNameController,
                isRequired: true,
                hintText: 'Enter police station',
                validationLabel: 'Police Station',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Product',
                controller: productNameController,
                isRequired: true,
                hintText: 'Enter product',
                validationLabel: 'Product',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone number',
                validationLabel: 'Phone number',
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
    divisionNameController.dispose();
    divisionIdController.dispose();
    policeStationNameController.dispose();
    policeStationIdController.dispose();
    productNameController.dispose();
    productIdController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void clearFields() {
    divisionNameController.clear();
    divisionIdController.clear();
    policeStationNameController.clear();
    policeStationIdController.clear();
    productNameController.clear();
    productIdController.clear();
    phoneController.clear();
  }
}
