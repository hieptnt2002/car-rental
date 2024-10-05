import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/presentation/screen/auth/login/login_screen.dart';
import 'package:car_rental/features/presentation/screen/auth/register/register_screen.dart';
import 'package:car_rental/features/presentation/screen/booking/booking_details/booking_details_screen.dart';
import 'package:car_rental/features/presentation/screen/car_details/car_details_screen.dart';
import 'package:car_rental/features/presentation/screen/booking/booking_list/booking_list_screen.dart';
import 'package:car_rental/features/presentation/screen/favorite/favorite_screen.dart';
import 'package:car_rental/features/presentation/screen/home/home_screen.dart';

import 'package:car_rental/features/presentation/screen/booking/add_booking/booking_review_screen.dart';
import 'package:car_rental/features/presentation/screen/booking/add_booking/booking_screen.dart';
import 'package:car_rental/features/presentation/screen/search/search_results_screen.dart';
import 'package:car_rental/features/presentation/screen/search/search_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static const String home = '/';
  static const String carDetails = '/carDetails';
  static const String booking = '/booking';
  static const String bookingReview = '/bookingReview';
  static const String login = '/login';
  static const String register = '/register';
  static const String bookingList = '/bookingList';
  static const String bookingDetails = '/bookingDetails';
  static const String search = '/search';
  static const String searchResults = '/searchResults';
  static const String favorite = '/favorite';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case Routes.carDetails:
        return MaterialPageRoute(
          builder: (_) => CarDetailsScreen(
            car: args['car'] as Car,
          ),
        );
      case Routes.booking:
        return MaterialPageRoute(
          builder: (_) => BookingScreen(car: args['car'] as Car),
        );

      case Routes.bookingReview:
        return MaterialPageRoute(
          builder: (_) => BookingReviewScreen(data: args),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.bookingList:
        return MaterialPageRoute(
          builder: (_) => const BookingListScreen(),
        );
      case Routes.bookingDetails:
        return MaterialPageRoute(
          builder: (_) => BookingDetailsScreen(booking: args['booking']),
        );
      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case Routes.searchResults:
        return MaterialPageRoute(
          builder: (_) => SearchResultsScreen(keyword: args['keyword']),
        );
      case Routes.favorite:
        return MaterialPageRoute(
          builder: (_) => const FavoriteScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
