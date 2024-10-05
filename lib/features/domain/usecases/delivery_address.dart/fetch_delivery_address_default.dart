import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/domain/repositories/delivery_address_repository.dart';
import 'package:car_rental/features/domain/usecases/delivery_address.dart/fetch_delivery_addresses.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class FetchDeliveryAddressDefault
    extends UseCase<DataResult<DeliveryAddress?>, DeliveryAddressParam> {
  final DeliveryAddressRepository _addressRepository;

  FetchDeliveryAddressDefault({
    required DeliveryAddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<DataResult<DeliveryAddress?>> execute(DeliveryAddressParam params) =>
      _addressRepository.getDeliveryAddressesDefault(userId: params.userId);
}
