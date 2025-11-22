import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/showDOBPicker.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/core/utils/widgets/row_fields.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/patients/patients_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/vaccine_card_request/vaccine_card_request_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/widgets/vaccine_request_popup.dart';

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
  final TextEditingController vaccinationCentre = TextEditingController();
  final TextEditingController nationality = TextEditingController();

  // Contact Info
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController whatsAppImo = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VaccineCardRequestBloc, VaccineCardRequestState>(
      listener: (context, state) {
        if (state is VaccineCardRequestFailure) {
          AppNotifier.showToast(
            state.message,
            type: MessageType.error,
          );
        } else if (state is VaccineCardRequestSuccess) {
          clearFields();
          context.read<PatientsBloc>().add(FetchPatientsEvent());
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const VaccineRequestPopup(),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is VaccineCardRequestLoading)
              Container(
                color: AppColors.black.withOpacity(0.6),
                child: const Loader(),
              )
          ],
        );
      },
    );
  }

  Widget content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Card Request'),
        leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  isRequired: false,
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
                  readOnly: true,
                  hintText: 'Select date',
                  validationLabel: 'Date of Birth',
                  onTap: () {
                    showDOBPicker(
                      context: context,
                      initialDate: DateTime(2000),
                      onDateSelected: (value) {
                        dateOfBirth.text = "${value.day}/${value.month}/${value.year}";
                      },
                    );
                  },
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
                      items: ['Male', 'Female', 'Other'],
                      controller: gender,
                      title: 'Select Gender',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Vaccination Centre',
                controller: vaccinationCentre,
                isRequired: true,
                hintText: 'Select vaccination centre',
                validationLabel: 'Vaccination Centre',
                readOnly: true,
                onTap: () {
                  showCustomBottomSheet(
                    context: context,
                    items: ['Vaccine Home', 'Vaccine Valley'],
                    controller: vaccinationCentre,
                    title: 'Select Vaccination Centre',
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nationality',
                controller: nationality,
                isRequired: true,
                hintText: 'Enter nationality',
                validationLabel: 'Nationality',
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
                label: 'WhatsApp',
                controller: whatsAppImo,
                isRequired: false,
                keyboardType: TextInputType.phone,
                hintText: 'Enter whatsapp number',
                validationLabel: 'WhatsApp',
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
                  onPressed: _submitRequest,
                  child: const Text('Submit Request'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<VaccineCardRequestBloc>().add(
        SubmitVaccineCardRequestEvent(
          firstNameEnglish: firstName.text.trim(),
          lastNameEnglish: lastName.text.trim(),
          gender: gender.text.trim(),
          vaccinationCentre: vaccinationCentre.text.trim(),
          birthDate: dateOfBirth.text.trim(),
          father: fatherName.text.trim(),
          mother: matherName.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          whatsapp: whatsAppImo.text.trim(),
          address: address.text.trim(),
          presentNationality: nationality.text.trim(),
        ),
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
    vaccinationCentre.dispose();
    nationality.dispose();
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
    vaccinationCentre.clear();
    nationality.clear();
    phoneNumber.clear();
    whatsAppImo.clear();
    address.clear();
  }
}
