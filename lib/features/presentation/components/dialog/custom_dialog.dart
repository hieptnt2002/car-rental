import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? content;
  final List<Widget>? body;
  final List<Widget> actions;
  const CustomDialog({
    super.key,
    required this.title,
    this.content,
    this.body,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 36,
                offset: const Offset(0, 8),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleAndContent(),
              _divider(),
              _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Text(
              title,
              style: AppTextStyle.w700TextColorLabelLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          if ((content ?? '').isNotEmpty)
            Text(content ?? '', style: AppTextStyle.textColorBodyMedium),
          if (body != null) ...body ?? [],
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: AppColors.gray300,
    );
  }

  Widget _buildActionButton() {
    return Row(
      children: List<Widget>.generate(actions.length, (index) {
        return Expanded(
          child: Row(
            children: [
              if (index != 0)
                Container(
                  width: 0.5,
                  height: double.infinity,
                  color: AppColors.gray200,
                ),
              Expanded(
                child: actions[index],
              ),
            ],
          ),
        );
      }),
    );
  }
}
