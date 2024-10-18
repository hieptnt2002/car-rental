import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/repositories/car_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class GetCarNames extends UseCase<DataResult<List<String>>, GetCarNamesParam> {
  final CarRepository _carRepository;

  GetCarNames({required CarRepository carRepository})
      : _carRepository = carRepository;
  @override
  Future<DataResult<List<String>>> execute(GetCarNamesParam params) =>
      _carRepository.getCarNamesByKeyword(keyword: params.keyword);
}

class GetCarNamesParam {
  final String keyword;

  GetCarNamesParam({required this.keyword});
}
