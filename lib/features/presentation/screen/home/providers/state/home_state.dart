import 'package:car_rental/features/domain/entities/car.dart';
import 'package:car_rental/features/domain/entities/carousel_image.dart';
import 'package:car_rental/features/domain/entities/brand.dart';

class HomeState {
  final List<Car> cars;
  final List<Brand> brands;
  final List<CarouselImage> carouselImages;
  HomeState({
    this.cars = const [],
    this.brands = const [],
    this.carouselImages = const [],
  });

  HomeState copyWith({
    List<Car>? cars,
    List<Brand>? brands,
    List<CarouselImage>? carouselImages,
  }) {
    return HomeState(
      cars: cars ?? this.cars,
      brands: brands ?? this.brands,
      carouselImages: carouselImages ?? this.carouselImages,
    );
  }
}
