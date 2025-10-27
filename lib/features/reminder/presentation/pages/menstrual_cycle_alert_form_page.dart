import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/data/models/menstrual_cycle_alert_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_menstrual_cycle_alerts/my_menstrual_cycle_alerts_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/menstrual_cycle_alert_form/menstrual_cycle_alert_form_bloc.dart';

class MenstrualCycleAlertFormPage extends StatefulWidget {
  static Route route({MenstrualCycleData? menstrualCycle}) => MaterialPageRoute(builder: (_) => MenstrualCycleAlertFormPage(menstrualCycle: menstrualCycle));

  final MenstrualCycleData? menstrualCycle;

  const MenstrualCycleAlertFormPage({super.key, this.menstrualCycle});

  @override
  State<MenstrualCycleAlertFormPage> createState() => _MenstrualCycleAlertFormPageState();
}

class _MenstrualCycleAlertFormPageState extends State<MenstrualCycleAlertFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.menstrualCycle != null) {
      startDateController.text = widget.menstrualCycle!.lastCycleStartDate ?? '';
      endDateController.text = widget.menstrualCycle!.lastCycleEndDate ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenstrualCycleAlertFormBloc, MenstrualCycleAlertFormState>(
      listener: (context, state) {
        if (state is MenstrualCycleAlertFormFailure) {
          AppNotifier.showToast(
            widget.menstrualCycle == null ? Messages.addMenstrualCycleAlertFailed : Messages.editMenstrualCycleAlertFailed,
            type: MessageType.error,
          );
        }
        if (state is MenstrualCycleAlertFormSuccess) {
          AppNotifier.showToast(
            widget.menstrualCycle == null ? Messages.addMenstrualCycleAlertSuccess : Messages.editMenstrualCycleAlertSuccess,
            type: MessageType.success,
          );
          clearFields();
          if (widget.menstrualCycle != null) {
            // context.read<MyMenstrualCycleAlertsBloc>().add(FetchMyMenstrualCycleAlertsEvent());
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is MenstrualCycleAlertFormLoading)
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
        title: Text(widget.menstrualCycle == null ? 'Add Menstrual Cycle Alert' : 'Edit Menstrual Cycle Alert'),
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
                label: 'Last Cycle Start Date',
                hintText: 'Select start date',
                controller: startDateController,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Last Cycle Start Date',
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
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Last Cycle End Date',
                hintText: 'Select end date',
                controller: endDateController,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Last Cycle End Date',
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveMenstrualCycle,
                  child: const Text('Save Menstrual Cycle Alert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMenstrualCycle() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<MenstrualCycleAlertFormBloc>().add(
        SaveMenstrualCycleAlertEvent(
          id: widget.menstrualCycle?.id,
          lastCycleStartDate: startDateController.text,
          lastCycleEndDate: endDateController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  void clearFields() {
    startDateController.clear();
    endDateController.clear();
  }
}