import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/features/domain/entities/brand.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  final Brand brand;
  const BrandItem({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColors.gray200,
          ),
          padding: const EdgeInsets.all(12),
          child: CachedNetworkImage(
            imageUrl: brand.image,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          brand.name,
          style: AppTextStyle.textColorLabelXSmall,
          overflow: TextOverflow.clip,
          maxLines: 1,
        ),
      ],
    );
  }
}
