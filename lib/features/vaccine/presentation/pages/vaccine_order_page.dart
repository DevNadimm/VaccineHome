import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_order/vaccine_order_bloc.dart';

class VaccineOrderPage extends StatefulWidget {
  static Route route(int id) => MaterialPageRoute(builder: (_) => VaccineOrderPage(productId: id));

  final int productId;

  const VaccineOrderPage({super.key, required this.productId});

  @override
  State<VaccineOrderPage> createState() => _VaccineOrderPageState();
}

class _VaccineOrderPageState extends State<VaccineOrderPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VaccineOrderBloc, VaccineOrderState>(
      listener: (context, state) {
        if (state is VaccineOrderFailure) {
          AppNotifier.showToast(
            Messages.vaccineOrderFailed,
            type: MessageType.error,
          );
        } else if (state is VaccineOrderSuccess) {
          clearFields();
          AppNotifier.showToast(
            Messages.vaccineOrderSuccess,
            type: MessageType.success,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is VaccineOrderLoading)
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
        title: const Text('Vaccine Order'),
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
                  onPressed: _submitOrder,
                  child: const Text('Submit Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitOrder() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<VaccineOrderBloc>().add(
        SendVaccineOrderEvent(
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
