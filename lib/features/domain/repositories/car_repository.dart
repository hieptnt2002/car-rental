import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/shared/domain/models/paginated_response.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

abstract class CarRepository {
  Future<DataResult<List<Car>>> getCars({
    required int pageNo,
    required int pageSize,
  });
  Future<DataResult<List<String>>> getCarNamesByKeyword({
    required String keyword,
  });
  Future<DataResult<PaginatedResponse<Car>>> getCarsWithKeywordAndSorting({
    required int pageNo,
    required int pageSize,
    required String keyword,
    String? sortDirection,
    String? sortBy,
  });
}
