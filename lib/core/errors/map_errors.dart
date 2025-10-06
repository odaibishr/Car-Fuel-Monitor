
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

enum MapErrorType {
  locationPermissionDenied,
  locationServiceDisabled,
  networkError,
  apiError,
  invalidResponse,
  unknown
}

class MapFailure  {
  final String message;
  final MapErrorType errorType;
  final StackTrace? stackTrace;
  
  const MapFailure(this.message, this.errorType, [this.stackTrace]);
  
  factory MapFailure.fromException(dynamic e, [StackTrace? stackTrace]) {
    if (e is MapFailure) return e;
    
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return MapFailure(
          'Connection timeout. Please check your internet connection.',
          MapErrorType.networkError,
          stackTrace,
        );
      }
      
      if (e.response != null) {
        if (e.response!.statusCode == 429) {
          return MapFailure(
            'Too many requests. Please try again later.',
            MapErrorType.apiError,
            stackTrace,
          );
        }
        
        return MapFailure(
          'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
          MapErrorType.apiError,
          stackTrace,
        );
      }
      
      return MapFailure(
        'Network error: ${e.message}',
        MapErrorType.networkError,
        stackTrace,
      );
    }
    
    if (e is PlatformException) {
      if (e.code == 'PERMISSION_DENIED') {
        return MapFailure(
          'Location permissions are required to use this feature.',
          MapErrorType.locationPermissionDenied,
          stackTrace,
        );
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        return MapFailure(
          'Location services are disabled. Please enable them to continue.',
          MapErrorType.locationServiceDisabled,
          stackTrace,
        );
      }
    }
    
    return MapFailure(
      e?.toString() ?? 'An unknown error occurred',
      MapErrorType.unknown,
      stackTrace,
    );
  }
  
  @override
  
  @override
  String toString() => 'MapFailure: $message (${errorType.toString()})';
}

extension EitherX<L, R> on Either<L, R> {
  R? get right => fold((_) => null, (r) => r);
  L? get left => fold((l) => l, (_) => null);
  bool get isRight => this is Right<L, R>;
  bool get isLeft => this is Left<L, R>;
}
