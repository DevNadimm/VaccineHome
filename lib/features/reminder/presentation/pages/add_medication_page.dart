import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/add_medication/add_medication_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/intake_toggle_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/time_picker_list_widget.dart';

class AddMedicationPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const AddMedicationPage());

  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController medicationName = TextEditingController();
  final TextEditingController medicationType = TextEditingController();
  // final TextEditingController startDate = TextEditingController();
  // final TextEditingController endDate = TextEditingController();

  // Future<void> _selectOnlyDate(TextEditingController controller) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2030),
  //   );
  //   if (picked != null) {
  //     controller.text = DateFormat('yyyy-MM-dd').format(picked);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMedicationBloc, AddMedicationState>(
      listener: (context, state) {
        if (state is AddMedicationFailure) {
          AppNotifier.showToast(Messages.addMedicationFailed, type: MessageType.error);
        }
        if (state is AddMedicationSuccess) {
          clearFields();
          AppNotifier.showToast(Messages.addMedicationSuccess, type: MessageType.success);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is AddMedicationLoading)
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
        title: const Text('Add Medication'),
        leading: IconButton(
          onPressed: () {
            context.read<IntakeToggleCubit>().reset();
            context.read<TimeListCubit>().clearControllers();
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
                label: 'Medication Name',
                controller: medicationName,
                isRequired: true,
                hintText: 'Enter medication name',
                validationLabel: 'Medication name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Medication Type',
                hintText: 'Select type',
                controller: medicationType,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Medication type',
                onTap: () {
                  showCustomBottomSheet(
                    context: context,
                    items: ['Tablet', 'Capsule', 'Injection', 'Syrup', 'Drops', 'Inhaler', 'Powder', 'Cream', 'Gel', 'Others'],
                    controller: medicationType,
                    title: 'Select Medication',
                  );
                },
              ),
              const SizedBox(height: 16),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: CustomTextField(
              //         label: 'Start Date',
              //         hintText: 'Select date',
              //         controller: startDate,
              //         isRequired: true,
              //         readOnly: true,
              //         validationLabel: 'Start date',
              //         onTap: () => _selectOnlyDate(startDate),
              //       ),
              //     ),
              //     const SizedBox(width: 16),
              //     Expanded(
              //       child: CustomTextField(
              //         label: 'End Date',
              //         hintText: 'Select date',
              //         controller: endDate,
              //         isRequired: true,
              //         readOnly: true,
              //         validationLabel: 'End date',
              //         onTap: () => _selectOnlyDate(endDate),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Time',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const TimePickerListWidget(),
              const SizedBox(height: 16),
              Text(
                'When to take?',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildIntakeToggle('Before Meals'),
                  const SizedBox(width: 16),
                  _buildIntakeToggle('After Meals'),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveMedication,
                  child: const Text(
                    'Save Medication',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntakeToggle(String label) {
    return BlocBuilder<IntakeToggleCubit, String>(
      builder: (context, intakeTiming) {
        final bool isSelected = intakeTiming == label;
        return Expanded(
          child: GestureDetector(
            onTap: isSelected
                ? null
                : () => context.read<IntakeToggleCubit>().toggle(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : AppColors.primaryFontColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _saveMedication() async {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<AddMedicationBloc>().add(
        SaveAddMedicationEvent(
          name: medicationName.text,
          type: medicationType.text,
          times: context.read<TimeListCubit>().state.map((e) => e.text).toList(),
          whenToTake: context.read<IntakeToggleCubit>().state,
        ),
      );
    }
  }

  @override
  void dispose() {
    medicationName.dispose();
    medicationType.dispose();
    super.dispose();
  }

  void clearFields() {
    medicationName.clear();
    medicationType.clear();
    context.read<TimeListCubit>().clearControllers();
    context.read<IntakeToggleCubit>().reset();
  }
}
