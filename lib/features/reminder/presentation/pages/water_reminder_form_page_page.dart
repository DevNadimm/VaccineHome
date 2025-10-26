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
import 'package:vaccine_home/features/reminder/data/models/water_reminder_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_water_reminders/my_water_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/water_reminder_form/water_reminder_form_bloc.dart';

class WaterReminderFormPage extends StatefulWidget {
  static Route route({WaterData? water}) => MaterialPageRoute(builder: (_) => WaterReminderFormPage(water: water));

  final WaterData? water;

  const WaterReminderFormPage({super.key, this.water});

  @override
  State<WaterReminderFormPage> createState() => _WaterReminderFormPageState();
}

class _WaterReminderFormPageState extends State<WaterReminderFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.water != null) {
      quantityController.text = widget.water!.totalWater ?? '';
      timeController.text = TimeConversionHelper.to12Hour(widget.water!.waterTimes?[0] ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WaterReminderFormBloc, WaterReminderFormState>(
      listener: (context, state) {
        if (state is WaterReminderFormFailure) {
          AppNotifier.showToast(
            widget.water == null ? Messages.addWaterReminderFailed : Messages.editWaterReminderFailed,
            type: MessageType.error,
          );
        }
        if (state is WaterReminderFormSuccess) {
          AppNotifier.showToast(
            widget.water == null ? Messages.addWaterReminderSuccess : Messages.editWaterReminderSuccess,
            type: MessageType.success,
          );
          clearFields();
          if (widget.water != null) {
            context.read<MyWaterRemindersBloc>().add(FetchMyWaterRemindersEvent());
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is WaterReminderFormLoading)
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
        title: Text(widget.water == null ? 'Add Water Alert' : 'Edit Water Alert'),
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
                label: 'Water Quantity (ml)',
                controller: quantityController,
                isRequired: true,
                keyboardType: TextInputType.number,
                hintText: 'Enter water quantity',
                validationLabel: 'Water quantity',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Alert Time',
                hintText: 'Select time',
                controller: timeController,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Alert Time',
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
                  onPressed: _saveWater,
                  child: const Text('Save Water Alert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveWater() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<WaterReminderFormBloc>().add(
        SaveWaterReminderEvent(
          id: widget.water?.id,
          totalWater: int.tryParse(quantityController.text) ?? 0,
          waterTimes: [timeController.text],
        ),
      );
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void clearFields() {
    quantityController.clear();
    timeController.clear();
  }
}
