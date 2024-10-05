import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/data/datasources/remote/car_api.dart';
import 'package:car_rental/features/domain/repositories/car_repository.dart';

class CarRepositoryImpl extends BaseRepository implements CarRepository {
  final CarApi _carApi;

  CarRepositoryImpl({required CarApi carApi}) : _carApi = carApi;

  @override
  Future<DataResult<List<Car>>> getCars({
    required int pageNo,
    required int pageSize,
  }) {
    return resultWithFuture(
      future: () async {
        final result =
            await _carApi.fetchCars(pageNo: pageNo, pageSize: pageSize);
        final cars = result.data.map((e) => e.toEntity()).toList();
        return cars;
      },
    );
  }
}
