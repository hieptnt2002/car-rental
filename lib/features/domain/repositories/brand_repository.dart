import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/domain/entities/brand.dart';

abstract class BrandRepository {
  Future<DataResult<List<Brand>>> getBrands();
}
