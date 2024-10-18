import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/domain/repositories/car_repository.dart';
import 'package:car_rental/shared/domain/models/paginated_response.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class GetCarsWithKeywordAndSorting extends UseCase<
    DataResult<PaginatedResponse<Car>>, CarsWithKeywordAndSortingParam> {
  final CarRepository _carRepository;

  GetCarsWithKeywordAndSorting({required CarRepository carRepository})
      : _carRepository = carRepository;
  @override
  Future<DataResult<PaginatedResponse<Car>>> execute(
    CarsWithKeywordAndSortingParam params,
  ) =>
      _carRepository.getCarsWithKeywordAndSorting(
        pageNo: params.pageNo,
        pageSize: params.pageSize,
        keyword: params.keyword,
        sortBy: params.sortBy,
        sortDirection: params.sortDirection,
      );
}

class CarsWithKeywordAndSortingParam {
  final int pageNo;
  final int pageSize;
  final String keyword;
  final String? sortBy;
  final String? sortDirection;

  CarsWithKeywordAndSortingParam({
    required this.pageNo,
    required this.pageSize,
    required this.keyword,
    this.sortBy,
    this.sortDirection,
  });
}
