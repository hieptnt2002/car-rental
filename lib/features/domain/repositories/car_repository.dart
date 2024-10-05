import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

abstract class CarRepository {
  Future<DataResult<List<Car>>> getCars({
    required int pageNo,
    required int pageSize,
  });
}
