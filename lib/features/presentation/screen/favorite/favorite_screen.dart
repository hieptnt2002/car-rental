import 'package:car_rental/features/presentation/components/card/car_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Car'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: cars.length,
        itemBuilder: (_, index) => CarItem(car: cars[index]),
      ),
    );
  }
}
