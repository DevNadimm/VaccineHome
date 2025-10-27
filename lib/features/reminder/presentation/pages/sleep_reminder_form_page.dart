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
import 'package:vaccine_home/features/reminder/data/models/sleep_reminder_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_sleep_reminders/my_sleep_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/sleep_reminder_form/sleep_reminder_form_bloc.dart';

class SleepReminderFormPage extends StatefulWidget {
  static Route route({SleepData? sleep}) => MaterialPageRoute(builder: (_) => SleepReminderFormPage(sleep: sleep));

  final SleepData? sleep;

  const SleepReminderFormPage({super.key, this.sleep});

  @override
  State<SleepReminderFormPage> createState() => _SleepReminderFormPageState();
}

class _SleepReminderFormPageState extends State<SleepReminderFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.sleep != null) {
      timeController.text = widget.sleep!.sleepTime != null ? TimeConversionHelper.to12Hour(widget.sleep!.sleepTime!) : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SleepReminderFormBloc, SleepReminderFormState>(
      listener: (context, state) {
        if (state is SleepReminderFormFailure) {
          AppNotifier.showToast(
            widget.sleep == null ? Messages.addSleepReminderFailed : Messages.editSleepReminderFailed,
            type: MessageType.error,
          );
        }
        if (state is SleepReminderFormSuccess) {
          AppNotifier.showToast(
            widget.sleep == null ? Messages.addSleepReminderSuccess : Messages.editSleepReminderSuccess,
            type: MessageType.success,
          );
          context.read<MySleepRemindersBloc>().add(FetchMySleepRemindersEvent());
          clearFields();
          if (widget.sleep != null) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is SleepReminderFormLoading)
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
        title: Text(widget.sleep == null ? 'Add Sleep Alert' : 'Edit Sleep Alert'),
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
                label: 'Sleep Time',
                hintText: 'Select time',
                controller: timeController,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Sleep Time',
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveSleep,
                  child: const Text('Save Sleep Alert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSleep() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<SleepReminderFormBloc>().add(
        SaveSleepReminderEvent(
          id: widget.sleep?.id,
          sleepTime: TimeConversionHelper.to24Hour(timeController.text),
        ),
      );
    }
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  void clearFields() {
    timeController.clear();
  }
}
