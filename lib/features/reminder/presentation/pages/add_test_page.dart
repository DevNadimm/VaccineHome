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
import 'package:vaccine_home/features/reminder/presentation/blocs/add_test/add_test_bloc.dart';

class AddTestPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const AddTestPage());

  const AddTestPage({super.key});

  @override
  State<AddTestPage> createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController testName = TextEditingController();
  final TextEditingController testDate = TextEditingController();
  final TextEditingController testTime = TextEditingController();
  final TextEditingController description = TextEditingController();

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
    return BlocConsumer<AddTestBloc, AddTestState>(
      listener: (context, state) {
        if (state is AddTestFailure) {
          AppNotifier.showToast(Messages.addTestFailed, type: MessageType.error);
        }
        if (state is AddTestSuccess) {
          clearFields();
          AppNotifier.showToast(Messages.addTestSuccess, type: MessageType.success);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is AddTestLoading)
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
        title: const Text('Add Test'),
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
                label: 'Test Name',
                controller: testName,
                isRequired: true,
                hintText: 'Enter test name',
                validationLabel: 'Test name',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Next Test Date',
                hintText: 'Select date',
                controller: testDate,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Date',
                onTap: () => _selectOnlyDate(testDate),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Next Test Time',
                hintText: 'Select time',
                controller: testTime,
                isRequired: true,
                readOnly: true,
                validationLabel: 'Time',
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    testTime.text = time.format(context);
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Description',
                controller: description,
                isRequired: false,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                hintText: 'Enter description',
                validationLabel: 'Description',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveConsultation,
                  child: const Text(
                    'Save Test',
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
      context.read<AddTestBloc>().add(
        SaveAddTestEvent(
          testName: testName.text,
          nextTestDate: testDate.text,
          nextTestTime: testTime.text,
          description: description.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    testName.dispose();
    testDate.dispose();
    testTime.dispose();
    description.dispose();
    super.dispose();
  }

  void clearFields() {
    testName.clear();
    testDate.clear();
    testTime.clear();
    description.clear();
  }
}
