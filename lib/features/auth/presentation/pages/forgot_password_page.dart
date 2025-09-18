import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/features/auth/presentation/pages/pin_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

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
        title: const Text('Forgot Password'),
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
                  "We’ll send a verification PIN to your email to confirm your account and reset your password securely.",
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
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  validationLabel: 'Email',
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
      Navigator.push(context, PinVerificationPage.route(_emailController.text));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}