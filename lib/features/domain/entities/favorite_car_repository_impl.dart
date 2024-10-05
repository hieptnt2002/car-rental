import 'package:car_rental/features/data/datasources/remote/favorite_api.dart';
import 'package:car_rental/features/domain/entities/favorite_car.dart';
import 'package:car_rental/features/domain/repositories/favorite_car_repository.dart';

class FavoriteCarRepositoryImpl implements FavoriteCarRepository {
  final FavoriteApi _favoriteApi;

  FavoriteCarRepositoryImpl({required FavoriteApi favoriteApi})
      : _favoriteApi = favoriteApi;

  @override
  Future<void> addFavoriteCar({
    required int carId,
    required String userId,
  }) async {}
  @override
  List<FavoriteCar> getAllFavoriteCar({required String userId}) {
    throw Exception();
  }

  @override
  bool isCarInFavorites({required int carId, required String userId}) {
    _favoriteApi;
    throw Exception();
  }
}
