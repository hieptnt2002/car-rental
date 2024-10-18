import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/shared/domain/models/paginated_response.dart';
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
    return resultWithMappedFuture(
      future: () async =>
          await _carApi.fetchCars(pageNo: pageNo, pageSize: pageSize),
      mapper: (models) => models.data.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Future<DataResult<List<String>>> getCarNamesByKeyword({
    required String keyword,
  }) {
    return resultWithFuture(
      future: () async {
        final res = await _carApi.fetchCarNamesByKeyword(keyword: keyword);
        return res;
      },
    );
  }

  @override
  Future<DataResult<PaginatedResponse<Car>>> getCarsWithKeywordAndSorting({
    required int pageNo,
    required int pageSize,
    required String keyword,
    String? sortDirection,
    String? sortBy,
  }) {
    return resultWithMappedFuture(
      future: () => _carApi.fetchCarsWithKeywordAndSorting(
        pageNo: pageNo,
        pageSize: pageSize,
        keyword: keyword,
        sortBy: sortBy,
        sortDirection: sortDirection,
      ),
      mapper: (pageModel) => PaginatedResponse(
        pageNo: pageModel.pageNo,
        totalPage: pageModel.totalPage,
        data: pageModel.data.map((e) => e.toEntity()).toList(),
      ),
    );
  }
}
