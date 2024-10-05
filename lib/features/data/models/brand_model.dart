import 'package:car_rental/features/data/datasources/_mappers/entity_convertable.dart';
import 'package:car_rental/features/domain/entities/brand.dart';

class BrandModel with EntityConvertable<BrandModel, Brand> {
  final int id;
  final String name;
  final String image;

  BrandModel({required this.id, required this.name, required this.image});

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  @override
  Brand toEntity() {
    return Brand(id: id, name: name, image: image);
  }
}
