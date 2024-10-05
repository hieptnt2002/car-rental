import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/presentation/screen/home/providers/home_provider.dart';
import 'package:car_rental/shared/presentations/data_state.dart';
import 'package:car_rental/features/presentation/components/card/brand_item.dart';
import 'package:car_rental/features/presentation/components/card/car_item.dart';
import 'package:car_rental/features/presentation/components/shimmer/car_shimmer.dart';
import 'package:car_rental/features/presentation/extension/dimension.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_svgs.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/home/providers/state/home_state.dart';
import 'package:car_rental/features/presentation/screen/home/widgets/brand_shimmer.dart';
import 'package:car_rental/features/presentation/screen/home/widgets/home_carousel_slider.dart';
import 'package:car_rental/features/presentation/screen/home/widgets/home_carousel_slider_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    return Scaffold(
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          _gap(),
          _buildSearch(),
          _gap(),
          _buildTitle(title: context.l10n.specialOffer),
          _gap(),
          _buildCarouselSlider(),
          _gap(),
          _buildListBrands(state),
          _gap(),
          _buildTitle(title: context.l10n.topDeals),
          _gap(),
          _buildTopDeals(state),
          _gap(),
          _buildTitle(title: context.l10n.trendCategory),
          _gap(),
          _buildTrendCategories(),
          _gap(),
          _buildTitle(
            title: context.l10n.recently,
            subTitle: context.l10n.viewRecently,
          ),
          _gap(),
          _buildCarRencently(),
          _gap(),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return SliverToBoxAdapter(
      child: ref.watch(homeProvider).when(
            loading: HomeCarouselSliderShimmer.new,
            data: (data) =>
                HomeCarouselSlider(carouselImages: data.carouselImages),
            error: (message, stackTrace) =>
                const HomeCarouselSliderShimmer(enable: false),
          ),
    );
  }

  Widget _buildTopDeals(DataState<HomeState> state) {
    return state.when<Widget>(
      loading: _buildCarShimmer,
      data: (data) {
        return _buildListCars(data.cars);
      },
      error: (message, stackTrace) {
        return _buildCarShimmer(false);
      },
    );
  }

  Widget _gap() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: 16),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(AppImages.appIcon, fit: BoxFit.cover),
      ),
      leadingWidth: 120,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.favorite);
          },
          icon: SvgPicture.asset(
            AppSvgs.favorite,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.login);
          },
          icon: SvgPicture.asset(
            AppSvgs.person,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildListBrands(DataState<HomeState> state) {
    return state.when(
      data: (data) {
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (_, index) {
            return BrandItem(
              brand: data.brands[index],
            );
          },
          itemCount: data.brands.length,
        );
      },
      error: (message, stackTrace) {
        return _buildBrandShimmer(false);
      },
      loading: _buildBrandShimmer,
    );
  }

  Widget _buildBrandShimmer([bool enabled = true]) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (_, __) {
        return BrandShimmer(enabled: enabled);
      },
      itemCount: 8,
    );
  }

  Widget _buildListCars(List<Car> cars) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return CarItem(
              car: cars[index],
            );
          },
          itemCount: 2,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
        ),
      ),
    );
  }

  Widget _buildCarShimmer([bool enabled = true]) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (_, __) => CarShimmer(
            enabled: enabled,
          ),
          separatorBuilder: (_, __) => const SizedBox(width: 8),
        ),
      ),
    );
  }

  Widget _buildTitle({required String title, String? subTitle}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.w700TextColorHeadingXSmall,
            ),
            if (subTitle != null)
              Text(
                subTitle,
                style: AppTextStyle.gray500LabelXSmall,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.search);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 48,
          child: TextField(
            decoration: InputDecoration(
              hintText: context.l10n.hintSearch,
              hintStyle: AppTextStyle.grayBodySmall,
              enabled: false,
              prefixIcon: const Icon(
                Icons.search,
                size: 24,
                color: AppColors.secondary,
              ),
              suffixIcon: const Icon(
                Icons.filter_alt_outlined,
                size: 24,
                color: AppColors.secondary,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: AppColors.gray200,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendCategories() {
    return SliverToBoxAdapter(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 150,
        ),
        itemBuilder: (context, index, realIndex) {
          return _buildTrendCategoryItem(trendCategories[index]);
        },
        itemCount: trendCategories.length,
      ),
    );
  }

  Widget _buildTrendCategoryItem(TrendCategory trendCategory) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: trendCategory.image,
              height: 150,
              width: context.percentWidth(78),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            trendCategory.name,
            style: AppTextStyle.whiteHeadingSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildCarRencently() {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          context.l10n.notFoundItem,
          style: AppTextStyle.gray500LabelLarge,
        ),
      ),
    );
  }
}

final trendCategories = [
  TrendCategory(
    id: 1,
    name: 'Consumer Cars',
    image:
        'https://cafebiz.cafebizcdn.vn/162123310254002176/2023/3/14/xegiamgia1-22552198-1678757903228-167875790337015481388.jpg',
  ),
  TrendCategory(
    id: 2,
    name: 'Sports Cars',
    image:
        'https://i.pinimg.com/736x/ef/f1/4e/eff14e99cad6e20ec8097498548f0c0f.jpg',
  ),
  TrendCategory(
    id: 3,
    name: 'Family Cars',
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6xP6hsSAyLm6SJDyVpqybzJNQT4nBt6kr6A&usqp=CAU',
  ),
  TrendCategory(
    id: 4,
    name: 'Travel/Camping Vans',
    image:
        'https://cdn.luxe.digital/media/20230210161837/best-camper-van-brands-reviews-luxe-digital-1200x600.jpg',
  ),
  TrendCategory(
    id: 5,
    name: 'Electric or Hybrid Cars',
    image:
        'https://dealerinspire-image-library-prod.s3.us-east-1.amazonaws.com/images/5PHcE4zTblN3r3vmUL2gSnHIVXrGqppZMXfvXnHV.jpg',
  ),
  TrendCategory(
    id: 6,
    name: 'Luxury Cars',
    image:
        'https://carsguide-res.cloudinary.com/image/upload/f_auto,fl_lossy,q_auto,t_cg_hero_large/v1/editorial/story/hero_image/2022-Rolls-Royce-Boat-Tail-Convertible-1001x565-%281%29.jpg',
  ),
];

class TrendCategory {
  final int id;
  final String name;
  final String image;

  TrendCategory({required this.id, required this.name, required this.image});
}
