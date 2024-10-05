import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/domain/entities/review.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewOverviewCard extends StatelessWidget {
  final List<Review> reviews;
  const ReviewOverviewCard({super.key, required this.reviews});

  double _averageRating() {
    if (reviews.isEmpty) return 0;
    double totalScores = 0;
    for (final review in reviews) {
      totalScores += review.score;
    }
    return totalScores / reviews.length;
  }

  int _totalReviewsByRating(int score) {
    return reviews.where((e) => e.score.ceil() == score).length;
  }

  @override
  Widget build(BuildContext context) {
    final avgRating = _averageRating();
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          Container(
            width: 150,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.gray200,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 7.0,
                  percent: avgRating > 0 ? avgRating / 5 : 0.0,
                  center: Text('$avgRating'),
                  progressColor: Colors.green,
                ),
                const SizedBox(height: 4),
                RatingBarIndicator(
                  rating: avgRating,
                  itemSize: 24,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '${reviews.length} ${context.l10n.reviewsAndComments}',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.textColorBodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return _buildRatingProgressItem(
                  score: index + 1,
                  totalReviewsByRating: _totalReviewsByRating(index + 1),
                  totalReviews: reviews.length,
                );
              },
              itemExtent: 180 / 5,
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingProgressItem({
    required final int score,
    required final int totalReviewsByRating,
    required final int totalReviews,
  }) {
    return Row(
      children: [
        Text(
          '$score',
          style: AppTextStyle.textColorBodySmall,
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.star_sharp,
          color: Colors.amber,
          size: 16,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: LinearPercentIndicator(
            percent:
                totalReviews > 0 ? totalReviewsByRating / totalReviews : 0.0,
            lineHeight: 8,
            animation: true,
            animateFromLastPercent: true,
            progressColor: AppColors.green600,
            barRadius: const Radius.circular(4),
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$totalReviewsByRating',
          style: AppTextStyle.textColorBodySmall,
        ),
      ],
    );
  }
}
