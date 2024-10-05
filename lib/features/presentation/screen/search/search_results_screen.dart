import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/presentation/components/card/car_item.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatefulWidget {
  final String keyword;
  const SearchResultsScreen({super.key, required this.keyword});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _isPriceAscending = true;
  int _currentTab = 0;
  final List<Car> cars = [];

  void _toggleTabBar(int index) {
    setState(() {
      if (_currentTab != index || _currentTab == 3) {
        switch (index) {
          case 0:
            // List default most rented
            break;
          case 1:
            break;
          case 2:
            // List default most rented
            break;
          case 3:
            _isPriceAscending =
                _currentTab == index ? !_isPriceAscending : _isPriceAscending;
            cars.sort(
              (a, b) => _isPriceAscending
                  ? a.pricePerDay.compareTo(b.pricePerDay)
                  : b.pricePerDay.compareTo(a.pricePerDay),
            );
            break;
        }
        _currentTab = index;
      }
    });
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
        body: TabBarView(
          children: List.generate(4, (index) => _buildListCar()),
        ),
      ),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      dividerColor: AppColors.gray500,
      indicatorColor: AppColors.secondary,
      isScrollable: true,
      labelColor: AppColors.secondary,
      unselectedLabelColor: AppColors.gray500,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.center,
      onTap: _toggleTabBar,
      tabs: [
        Tab(text: context.l10n.related),
        Tab(text: context.l10n.latest),
        Tab(text: context.l10n.mostRented),
        Tab(
          child: Row(
            children: [
              Text(context.l10n.price),
              Icon(
                _isPriceAscending
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
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: cars.length,
      itemBuilder: (_, index) => CarItem(car: cars[index]),
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
}
