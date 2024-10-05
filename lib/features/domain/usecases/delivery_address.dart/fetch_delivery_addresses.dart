import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/domain/repositories/delivery_address_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class FetchDeliveryAddressesUseCase
    extends UseCase<DataResult<List<DeliveryAddress>>, DeliveryAddressParam> {
  final DeliveryAddressRepository _addressRepository;

  FetchDeliveryAddressesUseCase({
    required DeliveryAddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<DataResult<List<DeliveryAddress>>> execute(
    DeliveryAddressParam params,
  ) =>
      _addressRepository.getDeliveryAddresses(userId: params.userId);
}

class DeliveryAddressParam {
  final int userId;

  DeliveryAddressParam({required this.userId});
}
