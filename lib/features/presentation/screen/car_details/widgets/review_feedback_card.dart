import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:car_rental/features/domain/entities/review.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';

class ReviewFeedBackCard extends StatelessWidget {
  final Review review;
  const ReviewFeedBackCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                review.user.name ?? 'Unknown',
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: AppTextStyle.w700TextColorSmall,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                const Icon(
                  Icons.verified,
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  context.l10n.verified,
                  maxLines: 1,
                  style: AppTextStyle.textColorLabelXSmall,
                ),
                const SizedBox(width: 4),
                RatingBarIndicator(
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFC107),
                  ),
                  rating: review.score,
                  itemSize: 12,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          review.comment,
          style: AppTextStyle.textColorBodySmall,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.thumb_up_off_alt,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${review.like}',
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.thumb_down_off_alt,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${review.dislike}',
                ),
              ],
            ),
            Text(
              review.createdAt.toString(),
              style: AppTextStyle.textColorBodyXSmall,
            ),
          ],
        ),
      ],
    );
  }
}
