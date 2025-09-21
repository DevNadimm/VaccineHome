import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_request/vaccine_request_bloc.dart';

class VaccineRequestPage extends StatefulWidget {
  static Route route(int id) => MaterialPageRoute(builder: (_) => VaccineRequestPage(productId: id));

  final int productId;

  const VaccineRequestPage({super.key, required this.productId});

  @override
  State<VaccineRequestPage> createState() => _VaccineRequestPageState();
}

class _VaccineRequestPageState extends State<VaccineRequestPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VaccineRequestBloc, VaccineRequestState>(
      listener: (context, state) {
        if (state is VaccineRequestFailure) {
          AppNotifier.showToast(
            Messages.vaccineRequestFailed,
            type: MessageType.error,
          );
        } else if (state is VaccineRequestSuccess) {
          clearFields();
          AppNotifier.showToast(
            Messages.vaccineRequestSuccess,
            type: MessageType.success,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is VaccineRequestLoading)
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
        title: const Text('Vaccine Request'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
                label: 'Phone Number',
                controller: _phoneController,
                isRequired: true,
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone number',
                validationLabel: 'Phone number',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Address',
                controller: _addressController,
                isRequired: true,
                hintText: 'Enter address',
                validationLabel: 'Address',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  child: const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<VaccineRequestBloc>().add(
        SendVaccineRequestEvent(
          phone: _phoneController.text,
          address: _addressController.text,
          productId: widget.productId,
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void clearFields() {
    _phoneController.clear();
    _addressController.clear();
  }
}
