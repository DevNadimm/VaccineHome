import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/core/utils/widgets/row_fields.dart';
import 'package:vaccine_home/features/reminder/data/models/physical_exercise_alert_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_physical_exercise_alerts/my_physical_exercise_alerts_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/physical_exercise_alert_form/physical_exercise_alert_form_bloc.dart';

class PhysicalExerciseAlertFormPage extends StatefulWidget {
  static Route route({ExerciseData? exercise}) => MaterialPageRoute(builder: (_) => PhysicalExerciseAlertFormPage(exercise: exercise));

  final ExerciseData? exercise;

  const PhysicalExerciseAlertFormPage({super.key, this.exercise});

  @override
  State<PhysicalExerciseAlertFormPage> createState() => _PhysicalExerciseAlertFormPageState();
}

class _PhysicalExerciseAlertFormPageState extends State<PhysicalExerciseAlertFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController exerciseNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.exercise != null) {
      exerciseNameController.text = widget.exercise!.exerciseName ?? '';
      durationController.text = widget.exercise!.duration ?? '';
      timeController.text = TimeConversionHelper.to12Hour(widget.exercise!.time ?? '');
      startDateController.text = widget.exercise!.startDate ?? '';
      endDateController.text = widget.exercise!.endDate ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhysicalExerciseAlertFormBloc, PhysicalExerciseAlertFormState>(
      listener: (context, state) {
        if (state is PhysicalExerciseAlertFormFailure) {
          AppNotifier.showToast(
            widget.exercise == null ? Messages.addPhysicalExerciseAlertFailed : Messages.editPhysicalExerciseAlertFailed,
            type: MessageType.error,
          );
        }
        if (state is PhysicalExerciseAlertFormSuccess) {
          AppNotifier.showToast(
            widget.exercise == null ? Messages.addPhysicalExerciseAlertSuccess : Messages.editPhysicalExerciseAlertSuccess,
            type: MessageType.success,
          );
          context.read<MyPhysicalExerciseAlertsBloc>().add(FetchMyPhysicalExerciseAlertsEvent());
          clearFields();
          if (widget.exercise != null) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is PhysicalExerciseAlertFormLoading)
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
        title: Text(widget.exercise == null ? 'Add Physical Exercise Alert' : 'Edit Physical Exercise Alert'),
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
                label: 'Exercise Name',
                hintText: 'Enter exercise name',
                controller: exerciseNameController,
                isRequired: true,
                validationLabel: 'Exercise Name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Duration',
                hintText: 'Enter duration',
                controller: durationController,
                isRequired: true,
                validationLabel: 'Duration',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Time',
                hintText: 'Select time',
                controller: timeController,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Time',
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    timeController.text = time.format(context);
                  }
                },
              ),
              const SizedBox(height: 16),
              RowFields(
                firstField: CustomTextField(
                  label: 'Start Date',
                  hintText: 'Select start date',
                  controller: startDateController,
                  isRequired: true,
                  readOnly: true,
                  validationLabel: 'Start Date',
                  onTap: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      startDateController.text = date.toString().split(' ')[0];
                    }
                  },
                ),
                lastField: CustomTextField(
                  label: 'End Date',
                  hintText: 'Select end date',
                  controller: endDateController,
                  isRequired: true,
                  readOnly: true,
                  validationLabel: 'End Date',
                  onTap: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      endDateController.text = date.toString().split(' ')[0];
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _savePhysicalExercise,
                  child: const Text('Save Physical Exercise Alert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePhysicalExercise() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<PhysicalExerciseAlertFormBloc>().add(
        SavePhysicalExerciseAlertEvent(
          id: widget.exercise?.id,
          exerciseName: exerciseNameController.text,
          duration: durationController.text,
          time: timeController.text,
          startDate: startDateController.text,
          endDate: endDateController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    exerciseNameController.dispose();
    durationController.dispose();
    timeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  void clearFields() {
    exerciseNameController.clear();
    durationController.clear();
    timeController.clear();
    startDateController.clear();
    endDateController.clear();
  }
}