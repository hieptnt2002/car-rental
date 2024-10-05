import 'dart:convert';

import 'package:car_rental/shared/data/remote/api_exception.dart';
import 'package:car_rental/config/environment.dart';
import 'package:car_rental/features/data/datasources/local/auth_local_data_source.dart';
import 'package:car_rental/shared/domain/models/response.dart';
import 'package:http/http.dart' as http;

enum HttpMethod { get, post, put, patch, delete }

class ApiClient {
  static const timeOut = Duration(seconds: 30);

  static Future<Map<String, String>> _createHeader({
    required Map<String, String> defaultHeader,
  }) async {
    final token = await AuthLocalDataSourceImpl().getToken();
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'language': 'vi',
      if (token?.isNotEmpty ?? false) 'Authorization': token!,
      ...defaultHeader,
    };
  }

  static Future<Response> request({
    required HttpMethod httpMethod,
    Map<String, dynamic> body = const {},
    Map<String, String> header = const {},
    Map<String, dynamic>? queryParameters,
    required String url,
  }) async {
    http.Response? response;
    final headers = await _createHeader(defaultHeader: header);
    final uri = Uri(
      scheme: Environment.apiScheme,
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: Environment.apiPrefix + url,
      queryParameters: queryParameters,
    );
    final encodedBody = jsonEncode(body);
    response = await _sendRequest(
      httpMethod: httpMethod,
      uri: uri,
      headers: headers,
      body: encodedBody,
    );
    return _handleResponse(response);
  }

  static Future<http.Response> _sendRequest({
    required HttpMethod httpMethod,
    required Uri uri,
    required Map<String, String> headers,
    String body = '{}',
  }) {
    switch (httpMethod) {
      case HttpMethod.get:
        return http.get(uri, headers: headers).timeout(
              timeOut,
              onTimeout: () => http.Response('Error', 504),
            );
      case HttpMethod.post:
        return http.post(uri, headers: headers, body: body).timeout(
              timeOut,
              onTimeout: () => http.Response('Error', 504),
            );
      case HttpMethod.put:
        return http.put(uri, headers: headers, body: body).timeout(
              timeOut,
              onTimeout: () => http.Response('Error', 504),
            );
      case HttpMethod.patch:
        return http.patch(uri, headers: headers, body: body).timeout(
              timeOut,
              onTimeout: () => http.Response('Error', 504),
            );
      case HttpMethod.delete:
        return http.delete(uri, headers: headers, body: body).timeout(
              timeOut,
              onTimeout: () => http.Response('Error', 504),
            );
    }
  }

  static Response _handleResponse(http.Response response) {
    final decodedBody = utf8.decode(response.bodyBytes);
    final jsonBody = jsonDecode(decodedBody);
    final message = jsonBody['message'] ?? 'An error occurred';
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Response(
        statusCode: response.statusCode,
        message: message,
        data: jsonBody['data'],
      );
    }

    switch (response.statusCode) {
      case 400:
        throw BadRequestException(message);
      case 401:
        throw UnauthorizedException(message);
      case 403:
        throw ForbiddenException(message);
      case 404:
        throw NotFoundException(message);
      case 422:
        throw UnprocessableContentException(message);
      case 500:
        throw InternalServerException(message);
      default:
        throw FetchDataException(
          'Error occurred while communicating with the server (Status: ${response.statusCode})',
        );
    }
  }
}
