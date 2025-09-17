import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Your Account'),
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
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  validationLabel: 'Email',
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
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        NavigationPage.route(),
                        (route) => false,
                      );
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  label: "Don't have an account? ",
                  actionText: "Register",
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      RegisterPage.route(),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapLogin(String email, String password) async {
    
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}