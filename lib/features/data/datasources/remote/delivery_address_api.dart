import 'package:car_rental/features/data/models/delivery_address_model.dart';
import 'package:car_rental/shared/data/remote/api_client.dart';

abstract class DeliveryAddressApi {
  Future<List<DeliveryAddressModel>> fetchDeliveryAddresses({
    required int userId,
  });
  Future<DeliveryAddressModel?> fetchDeliveryAddressesDefault({
    required int userId,
  });
}

class DeliveryAddressApiImpl implements DeliveryAddressApi {
  @override
  Future<List<DeliveryAddressModel>> fetchDeliveryAddresses({
    required int userId,
  }) async {
    final res = await ApiClient.request(
      httpMethod: HttpMethod.get,
      url: '/delivery-address/$userId',
    );
    final deliveryAddresses = (res.data as List)
        .map((e) => DeliveryAddressModel.fromMap(e as Map<String, dynamic>))
        .toList();
    return deliveryAddresses;
  }

  @override
  Future<DeliveryAddressModel?> fetchDeliveryAddressesDefault({
    required int userId,
  }) async {
    final res = await ApiClient.request(
      httpMethod: HttpMethod.get,
      url: '/delivery-address/default',
      queryParameters: {'user_id': '$userId'},
    );
    if (res.data == null) {
      return null;
    }
    return DeliveryAddressModel.fromMap(res.data as Map<String, dynamic>);
  }
}
