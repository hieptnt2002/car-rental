import 'package:car_rental/core/extensions/string_validator_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/utils/snack_bar.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/screen/auth/login/providers/login_provider.dart';
import 'package:car_rental/features/presentation/components/dialog/custom_dialog.dart';
import 'package:car_rental/features/presentation/extension/dimension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/auth/widgets/auth_button.dart';
import 'package:car_rental/features/presentation/screen/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final _userNameController = TextEditingController();
  late final _passwordController = TextEditingController();
  late final _formKey = GlobalKey<FormState>();
  bool _isHidePassword = true;

  void _handleLogin() {
    ref.read(loginProvider.notifier).login(
          username: _userNameController.text,
          password: _passwordController.text,
          onErrror: (msg) async {
            await _showLoginFailedDialog(msg);
            _passwordController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSuccess: (_) {
            USnackBar.showSuccessSnackBar(
              'Đăng nhập thành công. Chúc bạn có trải nghiệm tốt!',
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            );
          },
        );
  }

  Future<void> _showLoginFailedDialog(String msg) {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: 'Login Failed',
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
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            );
          },
        ),
        title: Text(context.l10n.login),
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
                  context.l10n.login.toUpperCase(),
                  style: AppTextStyle.textColorHeadingSmall,
                ),
                Text(
                  context.l10n.loginToYourAccount,
                  style: AppTextStyle.grayBodySmall,
                ),
                const SizedBox(height: 32),
                AuthTextField(
                  controller: _userNameController,
                  hintText: context.l10n.emailLabel,
                  prefixIcon: const Icon(
                    Icons.person,
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
                  hintText: context.l10n.passwordLabel,
                  prefixIcon: const Icon(
                    Icons.lock_person_rounded,
                    color: AppColors.textColor,
                  ),
                  suffixIcon: _buildVisiblePasswordIcon(),
                  obscureText: _isHidePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.enterPassword;
                    } else if (!value.isPasswordValid) {
                      return context.l10n.passwordRequirements;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {},
                    child: Text(
                      context.l10n.forgotPassword,
                      style: AppTextStyle.w700Gray500BodySmall,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: AuthButton(
                    title: context.l10n.login,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _handleLogin();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  context.l10n.continueWith,
                  style: AppTextStyle.gray500LabelMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AuthButton(
                        title: 'Facebook',
                        leading: Image.asset(
                          AppImages.facebook,
                          width: 24,
                          height: 24,
                        ),
                        type: AuthButtonType.secondary,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: AuthButton(
                        title: 'Google',
                        leading: Image.asset(
                          AppImages.google,
                          width: 24,
                          height: 24,
                        ),
                        type: AuthButtonType.secondary,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.noAccount,
                      style: AppTextStyle.textColorBodyMedium,
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: Text(
                        context.l10n.register,
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
