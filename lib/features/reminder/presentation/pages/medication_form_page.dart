import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/core/utils/widgets/row_fields.dart';
import 'package:vaccine_home/features/reminder/data/models/medication_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/duration_type_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/intake_toggle_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/medication_form/medication_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_medications/my_medications_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/time_picker_list_widget.dart';

class MedicationFormPage extends StatefulWidget {
  static Route route({Medication? medication}) => MaterialPageRoute(builder: (_) => MedicationFormPage(medication: medication));

  final Medication? medication;

  const MedicationFormPage({super.key, this.medication});

  @override
  State<MedicationFormPage> createState() => _MedicationFormPageState();
}

class _MedicationFormPageState extends State<MedicationFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController medicationName = TextEditingController();
  final TextEditingController medicationType = TextEditingController();
  final TextEditingController durationType = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    durationType.text = widget.medication?.duration ?? 'Regular';
    if (widget.medication != null) {
      medicationName.text = widget.medication!.medicationName ?? '';
      medicationType.text = widget.medication!.medicationType ?? '';
      startDate.text = widget.medication!.startDate ?? '';
      endDate.text = widget.medication!.endDate ?? '';
      durationType.text = widget.medication!.duration ?? 'Regular';
      context.read<TimeListCubit>().setTimes(widget.medication!.times?.map((t) => TimeConversionHelper.to12Hour(t)).toList() ?? []);
      context.read<IntakeToggleCubit>().changeIntake(widget.medication!.whenToTake ?? 'Before Meals');
      context.read<DurationTypeCubit>().setDurationType(widget.medication?.duration ?? 'Regular');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicationFormBloc, MedicationFormState>(
      listener: (context, state) {
        if (state is MedicationFormFailure) {
          AppNotifier.showToast(
            widget.medication == null ? Messages.addMedicationFailed : Messages.editMedicationFailed,
            type: MessageType.error,
          );
        }
        if (state is MedicationFormSuccess) {
          AppNotifier.showToast(
            widget.medication == null ? Messages.addMedicationSuccess : Messages.editMedicationSuccess,
            type: MessageType.success,
          );
          context.read<MyMedicationsBloc>().add(FetchMyMedicationsEvent());
          clearFields();
          if (widget.medication != null) {
            context.read<IntakeToggleCubit>().reset();
            context.read<DurationTypeCubit>().reset();
            context.read<TimeListCubit>().clearControllers();
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is MedicationFormLoading)
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
        title: Text(widget.medication == null ? 'Add Medication' : 'Edit Medication'),
        leading: AppBarBackBtn(
          onBack: () {
            context.read<IntakeToggleCubit>().reset();
            context.read<DurationTypeCubit>().reset();
            context.read<TimeListCubit>().clearControllers();
            Navigator.pop(context);
          },
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
              CustomTextField(
                label: 'Duration Type',
                hintText: 'Select type',
                controller: durationType,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Duration type',
                onTap: () async {
                  await showCustomBottomSheet(
                    context: context,
                    items: ["Regular", "Specific Date"],
                    controller: durationType,
                    title: 'Select Duration',
                  );
                  context.read<DurationTypeCubit>().setDurationType(durationType.text);
                },

              ),
              BlocBuilder<DurationTypeCubit, String>(
                builder: (context, state) {
                  if (state == "Specific Date") {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        RowFields(
                          firstField: CustomTextField(
                            label: 'Start Date',
                            hintText: 'Select date',
                            controller: startDate,
                            isRequired: true,
                            readOnly: true,
                            validationLabel: 'Date',
                            onTap: () => _selectOnlyDate(startDate),
                          ),
                          lastField: CustomTextField(
                            label: 'End Date',
                            hintText: 'Select date',
                            controller: endDate,
                            isRequired: true,
                            readOnly: true,
                            validationLabel: 'Date',
                            onTap: () => _selectOnlyDate(endDate),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
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

  void _saveMedication() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<MedicationFormBloc>().add(
        SaveMedicationEvent(
          id: widget.medication?.id,
          name: medicationName.text,
          type: medicationType.text,
          times: context.read<TimeListCubit>().state.map((e) => e.text).toList(),
          duration: durationType.text,
          startDate: startDate.text,
          endDate: endDate.text,
          whenToTake: context.read<IntakeToggleCubit>().state,
        ),
      );
    }
  }

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
  void dispose() {
    medicationName.dispose();
    medicationType.dispose();
    durationType.dispose();
    startDate.dispose();
    endDate.dispose();
    super.dispose();
  }

  void clearFields() {
    medicationName.clear();
    medicationType.clear();
    context.read<TimeListCubit>().clearControllers();
    context.read<IntakeToggleCubit>().reset();
  }
}
