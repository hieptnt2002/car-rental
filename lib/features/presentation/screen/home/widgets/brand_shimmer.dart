import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BrandShimmer extends StatelessWidget {
  final bool enabled;
  const BrandShimmer({super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Bone.circle(size: 45),
          SizedBox(height: 4),
          Bone.text(words: 1, style: AppTextStyle.textColorLabelXSmall),
        ],
      ),
    );
  }
}
