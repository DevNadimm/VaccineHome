import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:vaccine_home/features/auth/presentation/pages/register_page.dart';
import 'package:vaccine_home/features/auth/presentation/widgets/auth_footer.dart';
import 'package:vaccine_home/features/navigation/pages/navigation_page.dart';

class LoginPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            NavigationPage.route(),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is LoginLoading)
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
        title: const Text('Login to Your Account'),
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
                  "Welcome back! Access your vaccination updates and reminders anytime.",
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
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Enter password',
                  validationLabel: 'Confirm Password',
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, ForgotPasswordPage.route());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onTapLogin(),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  label: "Don't have an account? ",
                  actionText: "Register",
                  onTap: () {
                    Navigator.pushReplacement(context, RegisterPage.route());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapLogin() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginUserEvent(
          phone: _phoneController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}