import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/consultation_form/consultation_form_bloc.dart';

class AddConsultationPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const AddConsultationPage());

  const AddConsultationPage({super.key});

  @override
  State<AddConsultationPage> createState() => _AddConsultationPageState();
}

class _AddConsultationPageState extends State<AddConsultationPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController doctorName = TextEditingController();
  final TextEditingController consultationDate = TextEditingController();
  final TextEditingController consultationTime = TextEditingController();
  final TextEditingController address = TextEditingController();

  Future<void> _selectOnlyDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultationFormBloc, ConsultationFormState>(
      listener: (context, state) {
        if (state is ConsultationFormFailure) {
          AppNotifier.showToast(Messages.addConsultationFailed, type: MessageType.error);
        }
        if (state is ConsultationFormSuccess) {
          clearFields();
          AppNotifier.showToast(Messages.addConsultationSuccess, type: MessageType.success);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is ConsultationFormLoading)
              Container(
                color: AppColors.black.withOpacity(0.6),
                child: const Loader(),
              ),
          ],
        );
      },
    );
  }

  Widget content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Consultation'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Doctor Name',
                controller: doctorName,
                isRequired: true,
                hintText: 'Enter doctor name',
                validationLabel: 'Doctor name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Next Consultation Date',
                hintText: 'Select date',
                controller: consultationDate,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Date',
                onTap: () => _selectOnlyDate(consultationDate),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Next Consultation Time',
                hintText: 'Select time',
                controller: consultationTime,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Time',
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    consultationTime.text = time.format(context);
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Address',
                controller: address,
                isRequired: false,
                hintText: 'Enter address',
                validationLabel: 'Address',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveConsultation,
                  child: const Text(
                    'Save Consultation',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveConsultation() async {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<ConsultationFormBloc>().add(
        SaveConsultationEvent(
          doctorName: doctorName.text,
          nextConsultationDate: consultationDate.text,
          nextConsultationTime: consultationTime.text,
          address: address.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    doctorName.dispose();
    consultationDate.dispose();
    consultationTime.dispose();
    address.dispose();
    super.dispose();
  }

  void clearFields() {
    doctorName.clear();
    consultationDate.clear();
    consultationTime.clear();
    address.clear();
  }
}
