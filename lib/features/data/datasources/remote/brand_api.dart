import 'package:car_rental/shared/data/remote/api_client.dart';
import 'package:car_rental/features/data/models/brand_model.dart';

abstract class BrandApi {
  Future<List<BrandModel>> fetchBrands();
}

class BrandApiImpl implements BrandApi {
  @override
  Future<List<BrandModel>> fetchBrands() async {
    final res =
        await ApiClient.request(httpMethod: HttpMethod.get, url: '/brand');
    return (res.data['result'] as List<dynamic>)
        .map((e) => BrandModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
