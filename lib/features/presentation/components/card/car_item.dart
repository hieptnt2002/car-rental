import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/extensions/currency_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarItem extends ConsumerWidget {
  final Car car;

  const CarItem({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.carDetails,
          arguments: {'car': car},
        );
      },
      child: Container(
        width: 270,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gray200,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNameCar(),
            const SizedBox(height: 8),
            _buildBrand(),
            const SizedBox(height: 8),
            _buildImageCar(),
            _buildPriceCar(context, ref),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.owner.address,
                        style: AppTextStyle.grayBodyXSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      _buildRating(),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                CommonButton(
                  title: AppLocalizations.of(context)!.bookNow,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.booking,
                      arguments: {'car': car},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRating() {
    return RatingBarIndicator(
      rating: 2,
      itemSize: 16,
      itemBuilder: (context, index) => const Icon(
        Icons.star_rate_rounded,
        color: AppColors.secondary,
      ),
    );
  }

  Widget _buildPriceCar(BuildContext context, WidgetRef ref) {
    return Text(
      '${car.pricePerDay.formatCurrency(ref.watch(localeProvider))}/${AppLocalizations.of(context)!.day}',
      style: AppTextStyle.w700SecondaryMedium,
    );
  }

  Widget _buildImageCar() {
    return Expanded(
      // child: Hero(
      //   tag: car.id,
      //   child: CachedNetworkImage(
      //     imageUrl: car.image,
      //     width: double.maxFinite,
      //     fit: BoxFit.contain,
      //     errorWidget: (context, url, error) {
      //       return Image.asset(
      //         AppImages.appIcon,
      //         fit: BoxFit.contain,
      //       );
      //     },
      //   ),
      // ),
      child: Container(),
    );
  }

  Widget _buildNameCar() {
    return Text(
      car.name,
      style: AppTextStyle.w700TextColorSmall,
      maxLines: 1,
    );
  }

  Widget _buildBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CachedNetworkImage(
            imageUrl: car.brand.image,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            errorWidget: (context, url, error) => Image.asset(
              AppImages.appIcon,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            car.brand.name,
            style: AppTextStyle.textColorBodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
