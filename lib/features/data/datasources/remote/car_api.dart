import 'package:car_rental/features/data/models/car_model.dart';
import 'package:car_rental/shared/data/remote/api_client.dart';
import 'package:car_rental/shared/domain/models/paginated_response.dart';

abstract class CarApi {
  Future<PaginatedResponse<CarModel>> fetchCars({
    required int pageNo,
    required int pageSize,
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
}
