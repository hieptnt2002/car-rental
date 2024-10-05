import 'package:car_rental/core/usecase/usecase.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/domain/entities/carousel_image.dart';
import 'package:car_rental/features/domain/repositories/carousel_image_repository.dart';

class GetCarouselImages
    extends UseCaseNoParam<DataResult<List<CarouselImage>>> {
  final CarouselImageRepository _carouselImageRepository;

  GetCarouselImages({required CarouselImageRepository carouselImageRepository})
      : _carouselImageRepository = carouselImageRepository;

  @override
  Future<DataResult<List<CarouselImage>>> execute() =>
      _carouselImageRepository.getCarouselImages();
}
