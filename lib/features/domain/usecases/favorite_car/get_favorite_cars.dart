import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/favorite_car.dart';
import 'package:car_rental/features/domain/repositories/favorite_car_repository.dart';

class GetFavoriteCars extends UseCase<List<FavoriteCar>, GetFavoriteCarsParam> {
  final FavoriteCarRepository favoriteCarRepository;

  GetFavoriteCars({required this.favoriteCarRepository});
  @override
  Future<List<FavoriteCar>> execute(GetFavoriteCarsParam params) async =>
      favoriteCarRepository.getAllFavoriteCar(userId: params.userId);
}

class GetFavoriteCarsParam {
  final String userId;

  GetFavoriteCarsParam({required this.userId});
}
