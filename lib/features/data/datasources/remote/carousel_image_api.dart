import 'package:car_rental/shared/data/remote/api_client.dart';
import 'package:car_rental/features/data/models/carousel_image_model.dart';

abstract class CarouselImageApi {
  Future<List<CarouselImageModel>> fetchCarouselImages();
}

class CarouselImageApiImpl implements CarouselImageApi {
  @override
  Future<List<CarouselImageModel>> fetchCarouselImages() async {
    final res =
        await ApiClient.request(httpMethod: HttpMethod.get, url: '/banner');
    final banners = (res.data as List)
        .map((e) => CarouselImageModel.fromMap(e as Map<String, dynamic>))
        .toList();
    return banners;
  }
}
