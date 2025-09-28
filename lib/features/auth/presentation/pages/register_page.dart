import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/login_page.dart';
import 'package:vaccine_home/features/auth/presentation/widgets/auth_footer.dart';

class RegisterPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const RegisterPage());

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<RegisterPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is RegisterSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            LoginPage.route(),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is RegisterLoading)
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
        title: const Text('Register an Account'),
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
                  "Join Vaccine Home and take a step toward a healthier, safer tomorrow.",
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
                  label: 'Name',
                  controller: _nameController,
                  isRequired: true,
                  hintText: 'Enter name',
                  validationLabel: 'Name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  validationLabel: 'Email',
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Enter password',
                  validationLabel: 'Confirm Password',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState?.validate() ?? false) {
                        context.read<RegisterBloc>().add(
                          RegisterUserEvent(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            phone: _phoneController.text.trim(),
                            password: _passwordController.text.trim(),
                            confirmPassword: _confirmPasswordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  label: "Already have an account? ",
                  actionText: "Sign In",
                  onTap: () {
                    Navigator.pushReplacement(context, LoginPage.route());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}