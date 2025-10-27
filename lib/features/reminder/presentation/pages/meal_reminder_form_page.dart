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
import 'package:vaccine_home/features/reminder/data/models/meal_reminder_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/meal_reminder_form/meal_reminder_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_meal_reminders/my_meal_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/time_picker_list_widget.dart';

class MealReminderFormPage extends StatefulWidget {
  static Route route({MealData? meal}) => MaterialPageRoute(builder: (_) => MealReminderFormPage(meal: meal));

  final MealData? meal;

  const MealReminderFormPage({super.key, this.meal});

  @override
  State<MealReminderFormPage> createState() => _MealReminderFormPageState();
}

class _MealReminderFormPageState extends State<MealReminderFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController mealDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.meal != null) {
      mealDescription.text = widget.meal!.mealDescription ?? '';
      context.read<TimeListCubit>().setTimes(
        widget.meal!.mealTimes?.map((t) => TimeConversionHelper.to12Hour(t)).toList() ?? [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealReminderFormBloc, MealReminderFormState>(
      listener: (context, state) {
        if (state is MealReminderFormFailure) {
          AppNotifier.showToast(
            widget.meal == null ? Messages.addMealReminderFailed : Messages.editMealReminderFailed,
            type: MessageType.error,
          );
        }
        if (state is MealReminderFormSuccess) {
          AppNotifier.showToast(
            widget.meal == null ? Messages.addMealReminderSuccess : Messages.editMealReminderSuccess,
            type: MessageType.success,
          );
          context.read<MyMealRemindersBloc>().add(FetchMyMealRemindersEvent());
          clearFields();
          if (widget.meal != null) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is MealReminderFormLoading)
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
        title: Text(widget.meal == null ? 'Add Meal Alert' : 'Edit Meal Alert'),
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
                label: 'Meal Description',
                controller: mealDescription,
                isRequired: true,
                hintText: 'Enter meal description',
                validationLabel: 'Meal description',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Alert Time(s)',
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
                  onPressed: _saveMeal,
                  child: const Text('Save Meal Alert'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMeal() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<MealReminderFormBloc>().add(
        SaveMealReminderEvent(
          id: widget.meal?.id,
          mealDescription: mealDescription.text,
          mealTimes: context.read<TimeListCubit>().state.map((e) => e.text).toList(),
        ),
      );
    }
  }

  @override
  void dispose() {
    mealDescription.dispose();
    super.dispose();
  }

  void clearFields() {
    mealDescription.clear();
    context.read<TimeListCubit>().clearControllers();
  }
}
