extension StringCaseExtension on String {
  String toCamelCase() {
    final List<String> parts = split('_');
    return parts[0] +
        parts.skip(1).map((e) => e[0].toUpperCase() + e.substring(1)).join();
  }

  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
  }
}
