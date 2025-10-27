import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/time_conversion_helper.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/data/models/pathology_model.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_tests/my_tests_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/test_form/test_form_bloc.dart';

class TestFormPage extends StatefulWidget {
  static Route route({Pathology? test}) => MaterialPageRoute(builder: (_) => TestFormPage(test: test));

  final Pathology? test;

  const TestFormPage({super.key, this.test});

  @override
  State<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends State<TestFormPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController testName = TextEditingController();
  final TextEditingController testDate = TextEditingController();
  final TextEditingController testTime = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.test != null) {
      testName.text = widget.test!.testName ?? '';
      testDate.text = widget.test!.nextTestDate ?? '';
      testTime.text = widget.test!.nextTestTime != null ? TimeConversionHelper.to12Hour(widget.test!.nextTestTime!) : '';
      description.text = widget.test!.description ?? '';
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
  Widget build(BuildContext context) {
    return BlocConsumer<TestFormBloc, TestFormState>(
      listener: (context, state) {
        if (state is TestFormFailure) {
          AppNotifier.showToast(
            widget.test == null ? Messages.addTestFailed : Messages.editTestFailed,
            type: MessageType.error,
          );
        }
        if (state is TestFormSuccess) {
          AppNotifier.showToast(
            widget.test == null ? Messages.addTestSuccess : Messages.editTestSuccess,
            type: MessageType.success,
          );
          context.read<MyTestsBloc>().add(FetchMyTestsEvent());
          clearFields();
          if (widget.test != null) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is TestFormLoading)
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
        title: Text(widget.test == null ? 'Add Test' : 'Edit Test'),
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
                  onPressed: _saveTest,
                  child: const Text('Save Test'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTest() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<TestFormBloc>().add(
        SaveTestFormEvent(
          id: widget.test?.id,
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
