import 'package:car_rental/features/data/models/user_model.dart';
import 'package:hive/hive.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final fields = reader.readList();

    return UserModel(
      id: fields[0] as int,
      email: fields[1] as String,
      name: fields[2] as String?,
      address: fields[3] as String?,
      image: fields[4] as String?,
      coverImage: fields[5] as String?,
      phone: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeList([
      obj.id,
      obj.email,
      obj.name,
      obj.address,
      obj.image,
      obj.coverImage,
      obj.phone,
    ]);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
