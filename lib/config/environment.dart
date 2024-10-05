import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, staging, prod }

class Environment {
  static String fileName({required EnvironmentType type}) {
    switch (type) {
      case EnvironmentType.dev:
        return '.env.development';
      case EnvironmentType.staging:
        return '.env.staging';
      case EnvironmentType.prod:
        return '.env.production';
    }
  }

  static String get apiUrl => dotenv.env['API_URL'] ?? 'API URL not found!';

  static String get apiScheme {
    return dotenv.env['API_SCHEME'] ?? 'API SCHEME not found!';
  }

  static String get apiHost {
    return dotenv.env['API_HOST'] ?? 'API HOST not found!';
  }

  static int get apiPort {
    return int.parse(dotenv.env['API_PORT']!);
  }

  static String get apiPrefix {
    return dotenv.env['API_PREFIX'] ?? 'API PREFIX not found!';
  }

  static String get apiMediaUrl {
    return '$apiScheme:$apiHost:$apiPort/files';
  }
}
