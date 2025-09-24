import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/water_reminder_form/water_reminder_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/time_picker_list_widget.dart';

class WaterReminderFormPage extends StatefulWidget {
  static Route route({WaterData? water}) => MaterialPageRoute(builder: (_) => WaterReminderFormPage(water: water));

  final WaterData? water;

  const WaterReminderFormPage({super.key, this.water});

  @override
  State<WaterReminderFormPage> createState() => _WaterReminderFormPageState();
}

class _WaterReminderFormPageState extends State<WaterReminderFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController quantity = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.water != null) {
      quantity.text = widget.water!.totalWater ?? '';
      context.read<TimeListCubit>().setTimes(
        widget.water!.waterTimes?.map((t) => TimeConversionHelper.to12Hour(t)).toList() ?? [],
      );
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
        title: Text(widget.water == null ? 'Add Water Reminder' : 'Edit Water Reminder'),
        leading: AppBarBackBtn(
          onBack: () {
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
                label: 'Water Quantity (ml)',
                controller: quantity,
                isRequired: true,
                keyboardType: TextInputType.number,
                hintText: 'Enter water quantity',
                validationLabel: 'Water quantity',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Reminder Time(s)',
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveWater,
                  child: const Text('Save Water Reminder'),
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
          totalWater: int.tryParse(quantity.text) ?? 0,
          waterTimes: context.read<TimeListCubit>().state.map((e) => e.text).toList(),
        ),
      );
    }
  }

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  void clearFields() {
    quantity.clear();
    context.read<TimeListCubit>().clearControllers();
  }
}
