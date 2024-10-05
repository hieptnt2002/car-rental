import 'package:car_rental/features/data/datasources/remote/delivery_address_api.dart';
import 'package:car_rental/features/domain/entities/delivery_address.dart';
import 'package:car_rental/features/domain/repositories/delivery_address_repository.dart';
import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';

class DeliveryAddressRepositoryImpl extends BaseRepository
    implements DeliveryAddressRepository {
  final DeliveryAddressApi _addressApi;

  DeliveryAddressRepositoryImpl({required DeliveryAddressApi addressApi})
      : _addressApi = addressApi;

  @override
  Future<DataResult<List<DeliveryAddress>>> getDeliveryAddresses({
    required int userId,
  }) =>
      resultWithMappedFuture(
        future: () => _addressApi.fetchDeliveryAddresses(userId: userId),
        mapper: (models) => models.map((e) => e.toEntity()).toList(),
      );

  @override
  Future<DataResult<DeliveryAddress?>> getDeliveryAddressesDefault({
    required int userId,
  }) =>
      resultWithMappedFuture(
        future: () => _addressApi.fetchDeliveryAddressesDefault(userId: userId),
        mapper: (model) => model?.toEntity(),
      );
}
