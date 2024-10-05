import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/domain/entities/carousel_image.dart';

class CarouselImageModel
    with EntityConvertable<CarouselImageModel, CarouselImage> {
  final int id;
  final String title;
  final String image;
  final int carId;

  CarouselImageModel({
    required this.id,
    required this.title,
    required this.image,
    required this.carId,
  });

  factory CarouselImageModel.fromMap(Map<String, dynamic> map) {
    return CarouselImageModel(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      carId: map['carId'],
    );
  }

  @override
  CarouselImage toEntity() =>
      CarouselImage(id: id, title: title, image: image, carId: carId);
}
