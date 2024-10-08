import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

abstract class DeliveryAddressRepository {
  Future<DataResult<List<DeliveryAddress>>> getDeliveryAddresses();

  Future<DataResult<DeliveryAddress?>> getDeliveryAddressesDefault();
}
