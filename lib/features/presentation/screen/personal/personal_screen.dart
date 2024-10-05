import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_svgs.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.personal),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                context.l10n.general,
                style: AppTextStyle.gray500LabelLarge,
              ),
            ),
            _buildPersonalItem(
              title: context.l10n.editInfo,
              subtitle: context.l10n.viewInfo,
              leading: SvgPicture.asset(AppSvgs.person, width: 24),
            ),
            _buildPersonalItem(
              title: context.l10n.bookingHistory,
              subtitle: context.l10n.viewBookingStatus,
              leading: SvgPicture.asset(AppSvgs.cart, width: 24),
              onTap: () {
                Navigator.pushNamed(context, Routes.bookingList);
              },
            ),
            _buildPersonalItem(
              title: context.l10n.language,
              subtitle: context.l10n.englishVietnamese,
              leading: SvgPicture.asset(AppSvgs.multiLanguage, width: 24),
            ),
            _buildPersonalItem(
              title: context.l10n.address,
              subtitle: context.l10n.manageAddress,
              leading: SvgPicture.asset(AppSvgs.truck, width: 24),
            ),
            _buildPersonalItem(
              title: context.l10n.paymentMethod,
              subtitle: context.l10n.managePaymentMethods,
              leading: SvgPicture.asset(AppSvgs.payment, width: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                context.l10n.option,
                style: AppTextStyle.gray500LabelLarge,
              ),
            ),
            _buildPersonalItem(
              title: context.l10n.darkMode,
              subtitle: context.l10n.toggleDarkMode,
              leading: SvgPicture.asset(AppSvgs.darkMode, width: 24),
              trailing: _buildSwitch(onChanged: (value) {}, value: false),
            ),
            _buildPersonalItem(
              title: context.l10n.notification,
              subtitle: context.l10n.manageNotifications,
              leading: SvgPicture.asset(AppSvgs.bell, width: 24),
              trailing: _buildSwitch(onChanged: (value) {}, value: false),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                context.l10n.support,
                style: AppTextStyle.gray500LabelLarge,
              ),
            ),
            _buildPersonalItem(
              title: context.l10n.termsAndConditions,
              subtitle: context.l10n.viewTermsAndConditions,
              leading: SvgPicture.asset(AppSvgs.terms, width: 24),
            ),
            _buildPersonalItem(
              title: context.l10n.privacyPolicy,
              subtitle: context.l10n.viewPrivacyPolicy,
              leading: SvgPicture.asset(AppSvgs.privacyPolicy, width: 24),
            ),
            _buildPersonalItem(
              title: context.l10n.support,
              subtitle: context.l10n.needHelp,
              leading: SvgPicture.asset(AppSvgs.help, width: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CommonButton(
                title: context.l10n.logOut,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                type: ButtonType.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Switch _buildSwitch({
    ValueChanged? onChanged,
    required bool value,
  }) {
    return Switch(
      activeColor: AppColors.primary,
      trackOutlineColor: const MaterialStatePropertyAll(AppColors.textColor),
      inactiveThumbColor: AppColors.textColor,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildPersonalItem({
    required String title,
    required String subtitle,
    required Widget leading,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.gray300),
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.gray300,
          child: leading,
        ),
        title: Text(
          title,
          style: AppTextStyle.textColorLabelMedium,
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyle.grayBodySmall,
        ),
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
            ),
      ),
    );
  }
}
