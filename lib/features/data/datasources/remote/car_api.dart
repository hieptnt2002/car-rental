import 'package:car_rental/features/data/models/car_model.dart';
import 'package:car_rental/shared/data/remote/api_client.dart';
import 'package:car_rental/shared/domain/models/paginated_response.dart';

abstract class CarApi {
  Future<PaginatedResponse<CarModel>> fetchCars({
    required int pageNo,
    required int pageSize,
  });
  Future<List<String>> fetchCarNamesByKeyword({required String keyword});
  Future<PaginatedResponse<CarModel>> fetchCarsWithKeywordAndSorting({
    required int pageNo,
    required int pageSize,
    required String keyword,
    String? sortDirection,
    String? sortBy,
  });
}

class CarApiImpl implements CarApi {
  @override
  Future<PaginatedResponse<CarModel>> fetchCars({
    required int pageNo,
    required int pageSize,
  }) async {
    final res = await ApiClient.request(
      httpMethod: HttpMethod.get,
      url: '/car',
      queryParameters: {
        'pageNo': '$pageNo',
        'pageSize': '$pageSize',
      },
    );
    final paginatedCars = PaginatedResponse<CarModel>.fromJson(
      res.data,
      mappingData: (jsonData) {
        return jsonData
            .map((e) => CarModel.fromMap(e as Map<String, dynamic>))
            .toList();
      },
    );
    return paginatedCars;
  }

  @override
  Future<List<String>> fetchCarNamesByKeyword({required String keyword}) async {
    final res = await ApiClient.request(
      httpMethod: HttpMethod.get,
      url: '/car/names',
      queryParameters: {'keyword': keyword},
    );

    return (res.data as List).map((e) => e as String).toList();
  }

  @override
  Future<PaginatedResponse<CarModel>> fetchCarsWithKeywordAndSorting({
    required int pageNo,
    required int pageSize,
    required String keyword,
    String? sortDirection,
    String? sortBy,
  }) async {
    final parameters = {
      'pageNo': '$pageNo',
      'pageSize': '$pageSize',
      'keyword': keyword,
      if (sortDirection != null) 'sortDirection': sortDirection,
      if (sortBy != null) 'sortBy': sortBy,
    };

    final res = await ApiClient.request(
      httpMethod: HttpMethod.get,
      url: '/car/search-by',
      queryParameters: parameters,
    );
    return PaginatedResponse<CarModel>.fromJson(
      res.data,
      mappingData: (jsonData) => jsonData
          .map((e) => CarModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
