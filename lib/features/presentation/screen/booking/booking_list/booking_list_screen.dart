import 'package:car_rental/core/extensions/locale_extension.dart';
import 'package:car_rental/features/domain/entities/booking.dart';

import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/screen/booking/booking_list/providers/booking_list_provider.dart';
import 'package:car_rental/features/presentation/screen/booking/booking_list/widgets/booking_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingListScreen extends ConsumerStatefulWidget {
  const BookingListScreen({super.key});

  @override
  ConsumerState<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends ConsumerState<BookingListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      debugPrint('Load more');
    }
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
        backgroundColor: AppColors.gray200,
        appBar: AppBar(
          title: Text(context.l10n.bookingHistory),
          bottom: TabBar(
            dividerColor: AppColors.gray500,
            indicatorColor: AppColors.secondary,
            isScrollable: true,
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.center,
            onTap: (value) {
              final status = [
                BookingStatus.pending,
                BookingStatus.renting,
                BookingStatus.completed,
                BookingStatus.cancelled,
              ][value];
              ref
                  .read(bookingListProvider.notifier)
                  .getBookingsByStatus(status);
            },
            tabs: [
              Tab(text: context.l10n.waitingForConfirmation),
              Tab(text: context.l10n.rented),
              Tab(text: context.l10n.completed),
              Tab(text: context.l10n.cancelled),
            ],
          ),
        ),
        body: ref.watch(bookingListProvider).when(
              loading: () => const SizedBox(),
              data: (bookings) {
                return ListView.separated(
                  controller: _scrollController,
                  itemCount: bookings.length,
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: 8);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (_, index) {
                    return BookingItem(
                      booking: bookings[index],
                    );
                  },
                );
              },
              error: (message, stackTrace) {
                return const SizedBox();
              },
            ),
      ),
    );
  }
}
