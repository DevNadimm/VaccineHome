import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_product/vaccine_product_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_request/vaccine_request_bloc.dart';

class VaccineRequestPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineRequestPage());

  const VaccineRequestPage({super.key});

  @override
  State<VaccineRequestPage> createState() => _VaccineRequestPageState();
}

class _VaccineRequestPageState extends State<VaccineRequestPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  Map<String, int> _productNameToId = {};

  @override
  void initState() {
    _fetchProducts();
    super.initState();
  }

  void _fetchProducts() => context.read<VaccineProductBloc>().add(FetchVaccineProducts());

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VaccineProductBloc, VaccineProductState>(
          listener: (context, state) {
            if (state is VaccineProductFailure) {
              AppNotifier.showToast(
                Messages.fetchProductsFailed,
                type: MessageType.error,
              );
            }
          },
        ),
        BlocListener<VaccineRequestBloc, VaccineRequestState>(
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
            }
          },
        ),
      ],
      child: BlocBuilder<VaccineProductBloc, VaccineProductState>(
        builder: (context, productState) {
          return BlocBuilder<VaccineRequestBloc, VaccineRequestState>(
            builder: (context, requestState) {
              final isLoading = productState is VaccineProductLoading || requestState is VaccineRequestLoading;

              return Stack(
                children: [
                  content(),
                  if (isLoading)
                    Container(
                      color: AppColors.black.withOpacity(0.6),
                      child: const Loader(),
                    ),
                ],
              );
            },
          );
        },
      ),
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
              BlocBuilder<VaccineProductBloc, VaccineProductState>(
                builder: (context, state) {
                  return CustomTextField(
                    label: 'Vaccine Product',
                    controller: _productNameController,
                    isRequired: true,
                    readOnly: true,
                    onTap: () {
                      if (state is VaccineProductSuccess) {
                        print(state.products);
                        _productNameToId = {
                          for (var p in state.products)
                            (p.name ?? ''): p.id ?? 0,
                        };

                        showCustomBottomSheet(
                          context: context,
                          items: state.products.map((product) =>
                          product.name ?? '').toList(),
                          controller: _productNameController,
                          title: 'Select Product',
                        );
                      } else {
                        print(state);
                        showCustomBottomSheet(
                          context: context,
                          items: [],
                          controller: _productNameController,
                          title: 'Select Product',
                        );
                      }
                    },
                    hintText: 'Select vaccine product',
                    validationLabel: 'Vaccine Product',
                  );
                },
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
      final productId = _productNameToId[_productNameController.text] ?? 0;
      context.read<VaccineRequestBloc>().add(
        SendVaccineRequestEvent(
          phone: _phoneController.text,
          address: _addressController.text,
          productId: productId,
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  void clearFields() {
    _phoneController.clear();
    _addressController.clear();
    _productNameController.clear();
    _productNameToId.clear();
  }
}
