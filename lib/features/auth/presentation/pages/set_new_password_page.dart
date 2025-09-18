import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';

class SetNewPasswordPage extends StatefulWidget {
  static Route route(String email, String pin) => MaterialPageRoute(builder: (_) => SetNewPasswordPage(email: email, pin: pin));

  final String email;
  final String pin;

  const SetNewPasswordPage({super.key, required this.email, required this.pin});

  @override
  State<SetNewPasswordPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SetNewPasswordPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        content(),
        // if (state is LoginLoading)
        //   Container(
        //     color: AppColors.black.withOpacity(0.6),
        //     child: const Loader(),
        //   ),
      ],
    );
  }

  Widget content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set a New Password'),
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
      // Navigator.push(context, PinVerificationPage.route(_emailController.text));
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}