import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final List<Widget>? body;
  final List<Widget>? actions;
  const CustomDialog({
    super.key,
    this.title,
    this.content,
    this.body,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) _buildTitle(),
            const SizedBox(height: 16),
            if (content != null) _buildContent(),
            if (body != null) ...body ?? [],
            if (actions != null) ...[
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        title ?? '',
        style: AppTextStyle.w700TextColorLabelLarge,
        maxLines: 2,
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: Text(content ?? '', style: AppTextStyle.grayBodySmall),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < actions!.length; i++) ...[
          Expanded(child: actions![i]),
          if (i < actions!.length - 1 && actions!.length > 1)
            const SizedBox(width: 16),
        ],
      ],
    );
  }
}
