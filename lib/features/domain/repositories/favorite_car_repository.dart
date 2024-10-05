import 'package:car_rental/features/domain/entities/favorite_car.dart';

abstract class FavoriteCarRepository {
  Future<void> addFavoriteCar({required int carId, required String userId});
  List<FavoriteCar> getAllFavoriteCar({required String userId});
  bool isCarInFavorites({required int carId, required String userId});
}
