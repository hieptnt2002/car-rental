import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/domain/repositories/delivery_address_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class FetchDeliveryAddressDefault
    extends UseCaseNoParam<DataResult<DeliveryAddress?>> {
  final DeliveryAddressRepository _addressRepository;

  FetchDeliveryAddressDefault({
    required DeliveryAddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<DataResult<DeliveryAddress?>> execute() =>
      _addressRepository.getDeliveryAddressesDefault();
}
