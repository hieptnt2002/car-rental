import 'package:car_rental/shared/domain/repositories/base_repository.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:car_rental/features/data/datasources/remote/carousel_image_api.dart';
import 'package:car_rental/features/domain/entities/carousel_image.dart';
import 'package:car_rental/features/domain/repositories/carousel_image_repository.dart';

class CarouselImageRepositoryImpl extends BaseRepository
    implements CarouselImageRepository {
  final CarouselImageApi _carouselImageApi;

  CarouselImageRepositoryImpl({required CarouselImageApi carouselImageApi})
      : _carouselImageApi = carouselImageApi;

  @override
  Future<DataResult<List<CarouselImage>>> getCarouselImages() =>
      resultWithMappedFuture(
        future: _carouselImageApi.fetchCarouselImages,
        mapper: (data) => data.map((e) => e.toEntity()).toList(),
      );
}
