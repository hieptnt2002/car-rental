import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

abstract class DeliveryAddressRepository {
  Future<DataResult<List<DeliveryAddress>>> getDeliveryAddresses({
    required int userId,
  });

  Future<DataResult<DeliveryAddress?>> getDeliveryAddressesDefault({
    required int userId,
  });
}
