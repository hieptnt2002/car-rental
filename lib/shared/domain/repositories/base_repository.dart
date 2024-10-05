import 'dart:async';
import 'dart:io';
import 'package:car_rental/shared/data/remote/api_exception.dart';
import 'package:car_rental/shared/domain/repositories/data_result.dart';
import 'package:flutter/material.dart';

abstract class BaseRepository {
  Future<DataResult<T>> resultWithFuture<T>({
    required Future<T> Function() future,
  }) async {
    try {
      final res = await future.call();
      return Success(data: res);
    } on SocketException {
      return Error(exception: FetchDataException('No Internet connection'));
    } on ApiException catch (e) {
      _printError(e.toString());
      return Error(exception: e);
    } catch (e) {
      return Error(exception: FetchDataException('$e'));
    }
  }

  Future<DataResult<T>> resultWithMappedFuture<T, R>({
    required Future<R> Function() future,
    required T Function(R) mapper,
  }) async {
    try {
      final res = await future.call();
      return Success(data: mapper(res));
    } on SocketException {
      return Error(exception: FetchDataException('No Internet connection'));
    } on ApiException catch (e) {
      _printError(e.toString());
      return Error(exception: e);
    } catch (e) {
      _printError(e.toString());
      return Error(exception: FetchDataException('$e'));
    }
  }

  void _printError(String err) {
    debugPrint('\n' * 2);
    debugPrint('${'***' * 10} ERROR ${'***' * 10}');
    debugPrint(err);
    debugPrint('${'***' * 10} ----- ${'***' * 10}');
    debugPrint('\n' * 2);
  }
}
