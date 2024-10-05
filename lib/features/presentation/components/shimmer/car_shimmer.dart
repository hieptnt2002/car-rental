import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarShimmer extends StatelessWidget {
  final bool enabled;
  const CarShimmer({super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 300,
          maxWidth: 255,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gray200,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Bone.text(style: AppTextStyle.w700TextColorSmall, words: 2),
            const SizedBox(height: 8),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Bone.circle(size: 24),
                SizedBox(width: 8),
                Bone.text(style: AppTextStyle.textColorBodySmall, words: 1),
              ],
            ),
            const SizedBox(height: 8),
            _buildImageCarShimmer(),
            const Spacer(),
            const Skeleton.shade(
              child: Text(
                '\$???',
                style: AppTextStyle.w700GreyMedium,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Bone.text(
                        style: AppTextStyle.grayBodyXSmall,
                        words: 2,
                      ),
                      const SizedBox(height: 2),
                      _buildRatingShimmer(),
                    ],
                  ),
                ),
                Bone(
                  height: 40,
                  width: 90,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarShimmer() {
    return Skeleton.shade(
      child: Image.asset(
        AppImages.appIcon,
        height: 90,
        color: Colors.grey,
        width: double.maxFinite,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildRatingShimmer() {
    return Skeleton.shade(
      child: RatingBarIndicator(
        rating: 5,
        itemSize: 16,
        itemBuilder: (context, index) => const Icon(
          Icons.star_rate_rounded,
          color: AppColors.gray500,
        ),
      ),
    );
  }
}
