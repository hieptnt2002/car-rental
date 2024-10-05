import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class BookingCarItem extends StatelessWidget {
  final Car car;
  const BookingCarItem({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.gray100,
          ),
          child: CachedNetworkImage(
            imageUrl: car.image,
            height: 60,
            width: 60,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.w700TextColorSmall,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: car.image,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    car.brand.name,
                    style: AppTextStyle.grayBodyXSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
