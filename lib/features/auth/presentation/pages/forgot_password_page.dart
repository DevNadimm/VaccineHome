import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/pin_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is ForgotPasswordSuccess) {
          Navigator.push(context, PinVerificationPage.route(_phoneController.text.trim()));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is ForgotPasswordLoading)
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
        title: const Text('Forgot Password'),
        leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We’ll send a verification PIN to your phone number to confirm your account and reset your password securely.",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryFontColor,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Phone',
                  controller: _phoneController,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                  hintText: 'Enter phone',
                  validationLabel: 'Phone',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onTapSendPin(),
                    child: const Text('Send PIN'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapSendPin() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordBloc>().add(
        SendForgotPasswordPinEvent(phone: _phoneController.text.trim()),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}