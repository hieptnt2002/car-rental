import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/domain/entities/carousel_image.dart';

abstract class CarouselImageRepository {
  Future<DataResult<List<CarouselImage>>> getCarouselImages();
}
