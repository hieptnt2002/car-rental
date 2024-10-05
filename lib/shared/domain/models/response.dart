class Response {
  final int statusCode;
  final String? message;
  final dynamic data;

  Response({
    required this.statusCode,
    this.message,
    required this.data,
  });
  factory Response.fromMap(Map<String, dynamic> map) => Response(
        statusCode: map['status'],
        message: map['message'],
        data: map['data'],
      );

  @override
  String toString() {
    return 'statusCode=$statusCode\nMessage=$message\n data=$data';
  }
}
