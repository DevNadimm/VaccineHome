import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/online_vaccine_appointment/online_vaccine_appointment_bloc.dart';

class OnlineVaccineAppointmentPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const OnlineVaccineAppointmentPage());

  const OnlineVaccineAppointmentPage({super.key});

  @override
  State<OnlineVaccineAppointmentPage> createState() => _OnlineVaccineAppointmentPageState();
}

class _OnlineVaccineAppointmentPageState extends State<OnlineVaccineAppointmentPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController patientName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController appointmentDate = TextEditingController();
  final TextEditingController appointmentTime = TextEditingController();

  Future<void> _selectDate(TextEditingController controller) async {
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

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      controller.text = time.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlineVaccineAppointmentBloc, OnlineVaccineAppointmentState>(
      listener: (context, state) {
        if (state is OnlineVaccineAppointmentFailure) {
          AppNotifier.showToast(
            Messages.bookVaccineAppointmentFailed,
            type: MessageType.error,
          );
        } else if (state is OnlineVaccineAppointmentSuccess) {
          clearFields();
          AppNotifier.showToast(
            Messages.bookVaccineAppointmentSuccess,
            type: MessageType.success,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is OnlineVaccineAppointmentLoading)
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
        title: const Text('Book Vaccine Appointment'),
        leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Patient Name',
                controller: patientName,
                isRequired: true,
                hintText: 'Enter patient name',
                validationLabel: 'Patient name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone Number',
                controller: phone,
                isRequired: true,
                hintText: 'Enter phone number',
                validationLabel: 'Phone',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Appointment Date',
                controller: appointmentDate,
                hintText: 'Select date',
                isRequired: true,
                readOnly: true,
                validationLabel: 'Date',
                onTap: () => _selectDate(appointmentDate),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Appointment Time',
                controller: appointmentTime,
                hintText: 'Select time',
                isRequired: true,
                readOnly: true,
                validationLabel: 'Time',
                onTap: () => _selectTime(appointmentTime),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveAppointment,
                  child: const Text('Book Appointment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAppointment() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<OnlineVaccineAppointmentBloc>().add(
        BookVaccineAppointmentEvent(
          name: patientName.text,
          phone: phone.text,
          date: appointmentDate.text,
          time: appointmentTime.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    patientName.dispose();
    phone.dispose();
    appointmentDate.dispose();
    appointmentTime.dispose();
    super.dispose();
  }

  void clearFields() {
    patientName.clear();
    phone.clear();
    appointmentDate.clear();
    appointmentTime.clear();
  }
}
