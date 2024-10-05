import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/repositories/car_repository.dart';

class GetCars extends UseCase<DataResult<List<Car>>, GetCarParam> {
  final CarRepository _carRepository;

  GetCars({required CarRepository carRepository})
      : _carRepository = carRepository;
  @override
  Future<DataResult<List<Car>>> execute(GetCarParam params) =>
      _carRepository.getCars(
        pageNo: params.pageNo,
        pageSize: params.pageSize,
      );
}

class GetCarParam {
  final int pageNo;
  final int pageSize;

  GetCarParam({
    this.pageNo = 1,
    this.pageSize = 10,
  });
}
