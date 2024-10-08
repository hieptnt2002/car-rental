import 'package:car_rental/core/extensions/string_validator_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/utils/snack_bar.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/components/dialog/custom_dialog.dart';
import 'package:car_rental/features/presentation/extension/dimension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/auth/register/providers/register_provider.dart';
import 'package:car_rental/features/presentation/screen/auth/widgets/auth_button.dart';
import 'package:car_rental/features/presentation/screen/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final _userNameController = TextEditingController();
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _confirmPasswordController = TextEditingController();
  late final _formKey = GlobalKey<FormState>();
  bool _isHidePassword = true;

  void _handleRegister() {
    ref.read(registerProvider.notifier).register(
          username: _userNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          onErrror: (msg) async {
            await _showRegisterFailedDialog(msg);
            _passwordController.clear();
            _confirmPasswordController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSuccess: (_) {
            USnackBar.showSuccessSnackBar(
              'Tài khoản của bạn đã được tạo thành công. Hãy đăng nhập để bắt đầu!',
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (route) => false,
            );
          },
        );
  }

  Future<void> _showRegisterFailedDialog(String msg) {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: 'Register Failed',
          content: msg,
          actions: [
            CommonButton(
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'OK',
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.register),
      ),
      backgroundColor: AppColors.gray200,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  AppImages.appIconDark,
                  fit: BoxFit.contain,
                  width: context.percentWidth(50),
                  height: 120,
                ),
                Text(
                  context.l10n.register.toUpperCase(),
                  style: AppTextStyle.textColorHeadingSmall,
                ),
                Text(
                  context.l10n.createYourAccount,
                  style: AppTextStyle.grayBodySmall,
                ),
                const SizedBox(height: 32),
                AuthTextField(
                  controller: _userNameController,
                  hintText: context.l10n.userName,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.textColor,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.enterUsername;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _emailController,
                  hintText: context.l10n.emailLabel,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.textColor,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.enterEmail;
                    } else if (!value.isEmailValid) {
                      return context.l10n.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  prefixIcon: const Icon(
                    Icons.lock_person_rounded,
                    color: AppColors.textColor,
                  ),
                  hintText: context.l10n.passwordLabel,
                  suffixIcon: _buildVisiblePasswordIcon(),
                  obscureText: _isHidePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.enterPassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _confirmPasswordController,
                  prefixIcon: const Icon(
                    Icons.lock_person_rounded,
                    color: AppColors.textColor,
                  ),
                  hintText: context.l10n.confirmPassword,
                  obscureText: _isHidePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.enterConfirmPassword;
                    } else if (value != _passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  child: AuthButton(
                    title: context.l10n.register,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _handleRegister();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.youHaveAnAccount,
                      style: AppTextStyle.textColorBodyMedium,
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        context.l10n.login,
                        style: AppTextStyle.w700TextColorBodyMediumUnline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisiblePasswordIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isHidePassword = !_isHidePassword;
        });
      },
      icon: _isHidePassword
          ? const Icon(
              Icons.visibility,
              color: AppColors.textColor,
            )
          : const Icon(
              Icons.visibility_off,
              color: AppColors.textColor,
            ),
    );
  }
}
