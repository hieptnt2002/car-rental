import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/data/datasources/remote/brand_api.dart';
import 'package:car_rental/features/domain/repositories/brand_repository.dart';
import 'package:car_rental/features/domain/entities/brand.dart';

class BrandRepositoryImpl extends BaseRepository implements BrandRepository {
  final BrandApi _brandApi;

  BrandRepositoryImpl({required BrandApi brandApi}) : _brandApi = brandApi;

  @override
  Future<DataResult<List<Brand>>> getBrands() {
    return resultWithMappedFuture(
      future: _brandApi.fetchBrands,
      mapper: (data) => data.map((e) => e.toEntity()).toList(),
    );
  }
}
