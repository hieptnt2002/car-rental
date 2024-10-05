import 'package:car_rental/config/environment.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Flavor {
  Flavor._();
  static const channel = MethodChannel('flutter.method.channel');
  static Future<void> settings() async {
    final flavor = await channel.invokeMethod<String>('getFlavor') ?? 'dev';
    await dotenv.load(
      fileName:
          Environment.fileName(type: EnvironmentType.values.byName(flavor)),
    );
  }
}
