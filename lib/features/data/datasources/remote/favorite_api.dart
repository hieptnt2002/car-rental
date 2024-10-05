import 'package:car_rental/features/data/models/car_model.dart';

abstract class FavoriteApi {
  List<CarModel> getAllFavoriteCar({required int userId});
}

class FavoriteApiImpl implements FavoriteApi {
  @override
  List<CarModel> getAllFavoriteCar({required int userId}) {
    throw UnimplementedError();
  }
}
