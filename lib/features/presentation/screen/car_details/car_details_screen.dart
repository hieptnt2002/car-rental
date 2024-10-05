import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/extensions/currency_extension.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/core/utils/bottom_sheet.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/domain/entities/review.dart';
import 'package:car_rental/features/presentation/components/navigation/order_bottom_nav.dart';
import 'package:car_rental/features/presentation/extension/dimension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/car_details/widgets/review_feedback_card.dart';
import 'package:car_rental/features/presentation/screen/car_details/widgets/review_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarDetailsScreen extends ConsumerStatefulWidget {
  final Car car;
  const CarDetailsScreen({super.key, required this.car});

  @override
  ConsumerState<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends ConsumerState<CarDetailsScreen> {
  Car get _car => widget.car;

  double _calculateAverageRating() {
    if (_car.reviews.isEmpty) return 0;
    final totalScores =
        _car.reviews.fold(0.0, (sum, review) => sum + review.score);
    return totalScores / _car.reviews.length;
  }

  void _showCarDescriptionBottomSheet() {
    UBottomSheet.showBottomSheet(
      showCloseButton: false,
      height: context.percentHeight(40),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          _car.descriptions,
          style: AppTextStyle.textColorBodySmall,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  void _showReviewsBottomSheet() {
    UBottomSheet.showBottomSheet(
      title: context.l10n.reviewsAndComments,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReviewOverviewCard(reviews: _car.reviews),
            const SizedBox(height: 16),
            _buildReviewList(_car.reviews),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: OrderBottomNav(
        title:
            '${_car.pricePerDay.formatCurrency(ref.watch(localeProvider))}/${context.l10n.day}',
        subTitle: context.l10n.price,
        titleAction: context.l10n.bookNow,
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.booking,
            arguments: {'car': _car},
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.gray300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopIndicator(),
          const SizedBox(height: 8),
          _buildCarName(),
          _buildRatingSection(),
          _buildDivider(),
          _buildSpecificationsSection(),
          _buildDivider(),
          _buildDistributorSection(),
          _buildDivider(),
          _buildDescriptionSection(),
          _buildDivider(),
          _buildReviewsSection(),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: _car.image,
              height: context.percentHeight(40),
              fit: BoxFit.contain,
            ),
          ),
        ),
        AppBar(
          leading: const BackButton(color: AppColors.primary),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_rounded,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ],
    );
  }

  Widget _buildTopIndicator() {
    return Center(
      child: Container(
        height: 8,
        width: 54,
        decoration: BoxDecoration(
          color: AppColors.gray400,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }

  Widget _buildCarName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _car.name,
          style: AppTextStyle.w700TextColorLabelLarge,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Text(
          _car.brand.name,
          style: AppTextStyle.w700SecondarySmall,
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        RatingBarIndicator(
          rating: _calculateAverageRating(),
          itemSize: 24,
          itemBuilder: (context, index) => const Icon(
            Icons.star_rate_rounded,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '${_car.reviews.length} ${context.l10n.reviewsAndComments}',
          style: AppTextStyle.gray500BodySmall,
        ),
      ],
    );
  }

  Widget _buildSpecificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.specifications,
          style: AppTextStyle.w700TextColorLabelLarge,
        ),
        const SizedBox(height: 12),
        _buildSpecs(),
      ],
    );
  }

  Widget _buildSpecs() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildSpecItem(
            specName: context.l10n.seats,
            specValue: '${_car.seats}',
            icon: AppImages.seats,
          ),
          const SizedBox(width: 12),
          _buildSpecItem(
            specName: context.l10n.maxSpeed,
            specValue: '${_car.maxSpeed}',
            icon: AppImages.maxSpeed,
          ),
          const SizedBox(width: 12),
          _buildSpecItem(
            specName: context.l10n.engineFuel,
            specValue: _car.fuelType,
            icon: AppImages.engineFuel,
          ),
          const SizedBox(width: 12),
          _buildSpecItem(
            specName: context.l10n.enginePower,
            specValue: '${_car.enginePower}',
            icon: AppImages.enginePower,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({
    required String specName,
    required String specValue,
    required String icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              icon,
              width: 32,
              height: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            specName,
            style: AppTextStyle.w700TextColorSmall,
          ),
          Text(
            specValue,
            style: AppTextStyle.grayBodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildDistributorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.distributor,
          style: AppTextStyle.w700TextColorLabelLarge,
        ),
        const SizedBox(height: 12),
        _buildDistributor(),
      ],
    );
  }

  Widget _buildDistributor() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Container(
            color: AppColors.gray100,
            padding: const EdgeInsets.all(4),
            child: CachedNetworkImage(
              imageUrl: _car.image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _car.owner.name,
                style: AppTextStyle.textColorLabelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              _buildLocationDistributor(),
            ],
          ),
        ),
        const Icon(
          Icons.explore,
          color: AppColors.textColor,
          size: 42,
        ),
      ],
    );
  }

  Widget _buildLocationDistributor() {
    return Row(
      children: [
        Image.asset(
          AppImages.pin,
          width: 20,
          color: AppColors.gray500,
        ),
        Text(
          _car.owner.address,
          style: AppTextStyle.grayBodyXSmall,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.description,
          style: AppTextStyle.w700TextColorLabelLarge,
        ),
        const SizedBox(height: 12),
        Text(
          _car.descriptions,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.textColorBodySmall,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 12),
        _buildSeeMoreButton(
          label: context.l10n.seeMore,
          onPressed: _showCarDescriptionBottomSheet,
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.reviewsAndComments,
          style: AppTextStyle.w700TextColorLabelLarge,
        ),
        const SizedBox(height: 12),
        ReviewOverviewCard(reviews: _car.reviews),
        if (_car.reviews.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildReviewList(_car.reviews),
          _buildSeeMoreButton(
            label: context.l10n.seeMoreFeedback,
            onPressed: _showReviewsBottomSheet,
          ),
        ],
      ],
    );
  }

  Widget _buildReviewList(List<Review> reviews) {
    return ListView.separated(
      itemBuilder: (_, index) => ReviewFeedBackCard(review: reviews[index]),
      separatorBuilder: (_, __) => _buildDivider(),
      itemCount: reviews.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildSeeMoreButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyle.textColorBodySmall,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 32,
      thickness: 1,
      color: AppColors.gray300,
    );
  }
}
