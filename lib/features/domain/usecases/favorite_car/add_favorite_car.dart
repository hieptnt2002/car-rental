import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/repositories/favorite_car_repository.dart';

class AddFavoriteCar extends UseCase<void, AddFavoriteCarParams> {
  final FavoriteCarRepository favoriteCarRepository;

  AddFavoriteCar({required this.favoriteCarRepository});
  @override
  Future<void> execute(AddFavoriteCarParams params) =>
      favoriteCarRepository.addFavoriteCar(
        carId: params.carId,
        userId: params.userId,
      );
}

class AddFavoriteCarParams {
  final int carId;
  final String userId;

  AddFavoriteCarParams({required this.carId, required this.userId});
}
