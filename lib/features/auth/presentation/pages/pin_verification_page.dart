import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/pin_verification/pin_verification_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/set_new_password_page.dart';

class PinVerificationPage extends StatefulWidget {
  static Route route(String email) => MaterialPageRoute(builder: (_) => PinVerificationPage(email: email));

  final String email;

  const PinVerificationPage({super.key, required this.email});

  @override
  State<PinVerificationPage> createState() => _PinVerificationPageState();
}

class _PinVerificationPageState extends State<PinVerificationPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinVerificationBloc, PinVerificationState>(
      listener: (context, state) {
        if (state is PinVerificationFailure) {
          AppNotifier.showToast(Messages.verifyPinFailed, type: MessageType.error);
        }
        if (state is PinVerificationSuccess) {
          Navigator.push(context, SetNewPasswordPage.route(widget.email, _pinController.text));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is PinVerificationLoading)
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
        title: const Text('PIN Verification'),
        leading: const AppBarBackBtn(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: "Enter the 4-digit PIN sent to ",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryFontColor,
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondaryFontColor,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: " to verify your account.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _pinField(context),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final pin = _pinController.text.trim();
                    if (pin.isEmpty) {
                      AppNotifier.showToast('PIN cannot be empty', type: MessageType.error);
                    } else if (pin.length < 4) {
                      AppNotifier.showToast('PIN must be 4 digits', type: MessageType.error);
                    } else {
                      context.read<PinVerificationBloc>().add(
                        VerifyPinEvent(email: widget.email, pin: pin),
                      );
                    }
                  },
                  child: const Text("Verify PIN"),
                ),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  text: "Haven’t got the email yet? ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryFontColor,
                  ),
                  children: [
                    TextSpan(
                      text: "Resend Email",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        onTapResendEmail();
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapResendEmail() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordBloc>().add(
        SendForgotPasswordPinEvent(email: widget.email),
      );
    }
  }
  
  Widget _pinField(BuildContext context) {
    return PinCodeTextField(
      controller: _pinController,
      length: 4,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      backgroundColor: Colors.transparent,
      autoDisposeControllers: false,
      enableActiveFill: true,
      appContext: context,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryFontColor,
        ),
      ),
      cursorColor: AppColors.primaryColor,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(16),
        fieldHeight: 64,
        fieldWidth: 64,
        borderWidth: 2,
        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 8),
        activeColor: AppColors.primaryColor,
        selectedColor: AppColors.primaryColor,
        inactiveColor: AppColors.inputBorderColor,
        disabledColor: Colors.grey.shade300,
        activeFillColor: AppColors.white,
        selectedFillColor: AppColors.cardOverlay,
        inactiveFillColor: AppColors.white,
      ),
    );
  }
}
