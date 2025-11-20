import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/set_new_password/set_new_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/login_page.dart';

class SetNewPasswordPage extends StatefulWidget {
  static Route route(String phone, String pin) => MaterialPageRoute(builder: (_) => SetNewPasswordPage(phone: phone, pin: pin));

  final String phone;
  final String pin;

  const SetNewPasswordPage({super.key, required this.phone, required this.pin});

  @override
  State<SetNewPasswordPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SetNewPasswordPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetNewPasswordBloc, SetNewPasswordState>(
      listener: (context, state) {
        if (state is SetNewPasswordFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is SetNewPasswordSuccess) {
          AppNotifier.showToast(Messages.passwordSet, type: MessageType.success);
          Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is SetNewPasswordLoading)
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
        title: const Text('Set a New Password'),
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
                  "Create a new password. Ensure it differs from previous ones for security.",
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
                  label: 'New Password',
                  controller: _passwordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Enter new password',
                  validationLabel: 'New Password',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm New Password',
                  controller: _confirmPasswordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Re-enter your new password',
                  validationLabel: 'Confirm New Password',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onTapUpdatePassword(),
                    child: const Text('Update Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapUpdatePassword() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<SetNewPasswordBloc>().add(
        SetPasswordEvent(
          phone: widget.phone,
          pin: widget.pin,
          newPassword: _passwordController.text.trim(),
          confirmNewPassword: _confirmPasswordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}