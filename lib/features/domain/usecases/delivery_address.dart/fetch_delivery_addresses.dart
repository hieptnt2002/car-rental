import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/domain/repositories/delivery_address_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class FetchDeliveryAddressesUseCase
    extends UseCaseNoParam<DataResult<List<DeliveryAddress>>> {
  final DeliveryAddressRepository _addressRepository;

  FetchDeliveryAddressesUseCase({
    required DeliveryAddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<DataResult<List<DeliveryAddress>>> execute() =>
      _addressRepository.getDeliveryAddresses();
}
