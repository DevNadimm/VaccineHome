import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/change_password/change_password_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ChangePasswordPage());

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is ChangePasswordSuccess) {
          AppNotifier.showToast(Messages.changePasswordSuccess, type: MessageType.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is ChangePasswordLoading)
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
        title: const Text('Change Password'),
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
                label: 'Current Password',
                controller: _currentPassword,
                isRequired: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Enter current password',
                validationLabel: 'Current Password',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'New Password',
                controller: _newPassword,
                isRequired: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Enter new password',
                validationLabel: 'New Password',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm New Password',
                controller: _confirmNewPassword,
                isRequired: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Re-enter your new password',
                validationLabel: 'Confirm New Password',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (globalKey.currentState?.validate() ?? false) {
      context.read<ChangePasswordBloc>().add(
        SaveChangePasswordEvent(
          currentPass: _currentPassword.text.trim(),
          newPass: _newPassword.text.trim(),
          confirmNewPass: _confirmNewPassword.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }
}
