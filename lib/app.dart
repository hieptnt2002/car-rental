import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/core/providers/locale_provider.dart';
import 'package:car_rental/core/utils/snack_bar.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_svgs.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:car_rental/features/presentation/resources/route_manager.dart';
import 'package:car_rental/features/presentation/screen/home/home_screen.dart';
import 'package:car_rental/features/presentation/screen/personal/personal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: const MainApp(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(localeProvider),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(color: AppColors.white),
          titleTextStyle: AppTextStyle.whiteHeadingXSmall,
          surfaceTintColor: Colors.transparent,
        ),
        colorScheme: const ColorScheme.light(primary: AppColors.primary),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          dividerColor: AppColors.primary,
          headerBackgroundColor: AppColors.primary,
          headerForegroundColor: Colors.white,
        ),
      ),
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: Routes.rootNavigatorKey,
      scaffoldMessengerKey: USnackBar.messengerKey,
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _activeTabIndex,
        children: const [
          HomeScreen(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
          PersonalScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        onTabChange: (index) {
          setState(() {
            _activeTabIndex = index;
          });
        },
      ),
    );
  }
}

class CustomBottomNavigation extends StatefulWidget {
  final ValueChanged<int> onTabChange;
  const CustomBottomNavigation({super.key, required this.onTabChange});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildBottomNavItem(
          icon: AppSvgs.home,
          label: context.l10n.home,
          index: 0,
        ),
        _buildBottomNavItem(
          icon: AppSvgs.category,
          label: context.l10n.category,
          index: 1,
        ),
        _buildBottomNavItem(
          icon: AppSvgs.explore,
          label: context.l10n.explore,
          index: 2,
        ),
        _buildBottomNavItem(
          icon: AppSvgs.bell,
          label: context.l10n.notification,
          index: 3,
        ),
        _buildBottomNavItem(
          icon: AppSvgs.person,
          label: context.l10n.personal,
          index: 4,
        ),
      ],
      currentIndex: _currentSelectedIndex,
      onTap: (index) {
        setState(() {
          widget.onTabChange(index);
          _currentSelectedIndex = index;
        });
      },
      showUnselectedLabels: false,
      backgroundColor: AppColors.primary,
      selectedItemColor: AppColors.secondary,
      type: BottomNavigationBarType.fixed,
    );
  }

  BottomNavigationBarItem _buildBottomNavItem({
    required String icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          index == _currentSelectedIndex
              ? AppColors.secondary
              : AppColors.white,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
