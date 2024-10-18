import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/indicator/circle_indicator.dart';
import 'package:car_rental/features/presentation/components/card/car_item.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_images.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/search/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  final String keyword;
  const SearchResultsScreen({super.key, required this.keyword});

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  final ScrollController _scrollController = ScrollController();
  late final _searchResultsNotifier = ref.read(searchResultsProvider.notifier);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchResultsNotifier.searchAndSortCars(keyword: widget.keyword);
    });
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels > 0) {
      _searchResultsNotifier.loadMoreCars();
    }
  }

  Future<void> _jumpToEndPage() {
    return Future.delayed(
      Duration.zero,
      () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: _buildTextFieldSearch(),
          leading: const BackButton(color: AppColors.black),
          backgroundColor: AppColors.white,
          titleSpacing: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: AppColors.secondary,
                size: 32,
              ),
            ),
          ],
          bottom: _buildTabBar(context),
        ),
        body: _buildListCar(),
      ),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      dividerColor: AppColors.gray300,
      indicatorColor: AppColors.secondary,
      isScrollable: true,
      labelColor: AppColors.secondary,
      unselectedLabelColor: AppColors.gray500,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.center,
      onTap: (value) {
        _searchResultsNotifier.toggleTab(value, widget.keyword);
      },
      tabs: [
        Tab(text: context.l10n.related),
        Tab(text: context.l10n.latest),
        Tab(text: context.l10n.mostRented),
        Tab(
          child: Row(
            children: [
              Text(context.l10n.price),
              Icon(
                _searchResultsNotifier.isPriceSortingAscending
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListCar() {
    return ref.watch(searchResultsProvider).stateCars.when(
      loading: () {
        return const Center(
          child: SpinKitCircle(
            color: AppColors.secondary,
            size: 48,
          ),
        );
      },
      data: (cars) {
        if (cars.isEmpty) return _buildNotFound();
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: cars.length + 1,
          controller: _scrollController,
          itemBuilder: (_, index) {
            if (index == cars.length) {
              if (ref.watch(searchResultsProvider).hasLoadingMore) {
                _jumpToEndPage();
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: SpinKitCircle(
                    color: AppColors.secondary,
                    size: 32,
                  ),
                );
              }
              return const SizedBox(height: 0);
            }
            return CarItem(car: cars[index]);
          },
        );
      },
      error: (message, stackTrace) {
        return Text(message, style: AppTextStyle.redLabelSmall);
      },
    );
  }

  Widget _buildTextFieldSearch() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.search,
          arguments: {'keyword': widget.keyword},
        );
      },
      child: SizedBox(
        width: double.maxFinite,
        height: 40,
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            hintText: widget.keyword,
            hintStyle: AppTextStyle.grayBodySmall,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.secondary),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: const Icon(Icons.search),
            suffixIconConstraints: const BoxConstraints.expand(width: 30),
          ),
          cursorColor: AppColors.textColor,
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.cartEmpty, width: 120, height: 120),
          const Text(
            'Không có xe nào!',
            style: AppTextStyle.grayBodyMedium,
          ),
        ],
      ),
    );
  }
}
