import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/domain/entities/brand.dart';
import 'package:car_rental/features/domain/repositories/brand_repository.dart';

class GetBrands extends UseCaseNoParam<DataResult<List<Brand>>> {
  final BrandRepository _brandRepository;

  GetBrands({required BrandRepository brandRepository})
      : _brandRepository = brandRepository;

  @override
  Future<DataResult<List<Brand>>> execute() {
    return _brandRepository.getBrands();
  }
}
