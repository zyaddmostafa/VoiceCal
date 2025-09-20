import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(error) {
    // Handle Google Sign-In exceptions
    if (error is GoogleSignInException) {
      return _handleGoogleSignInException(error);
    }

    // Handle Supabase Auth exceptions
    if (error is AuthException) {
      return _handleSupabaseAuthException(error);
    }

    // Handle Platform exceptions
    if (error is PlatformException) {
      return _handlePlatformException(error);
    }

    // Handle Network exceptions
    if (error is SocketException) {
      return ApiErrorModel(
        message:
            "Network error. Please check your internet connection and try again.",
      );
    }

    if (error is HttpException) {
      return ApiErrorModel(message: "Server error. Please try again later.");
    }

    if (error is FormatException) {
      return ApiErrorModel(
        message: "Invalid response format. Please try again.",
      );
    }

    // Handle Dio exceptions
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: "NO internet Connection Check your internet",
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server");
        case DioExceptionType.unknown:
          return ApiErrorModel(
            message:
                "Connection to the server failed due to internet connection",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout in connection with the server",
          );
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    }

    // Handle generic exceptions
    return _handleGenericException(error);
  }

  static ApiErrorModel _handleGoogleSignInException(
    GoogleSignInException exception,
  ) {
    final exceptionString = exception.toString();
    final errorMessage = exceptionString.toLowerCase();

    if (errorMessage.contains('canceled') ||
        errorMessage.contains('user_canceled')) {
      return ApiErrorModel(message: 'Sign-in was canceled. Please try again.');
    } else if (errorMessage.contains('sign_in_required')) {
      return ApiErrorModel(
        message: 'Sign-in required. Please authenticate with Google.',
      );
    } else if (errorMessage.contains('account_restricted')) {
      return ApiErrorModel(
        message:
            'Google account is restricted. Please use a different account.',
      );
    } else if (errorMessage.contains('invalid_account')) {
      return ApiErrorModel(
        message: 'Invalid Google account. Please select a valid account.',
      );
    } else if (errorMessage.contains('permission_denied')) {
      return ApiErrorModel(
        message: 'Permission denied. Please grant necessary permissions.',
      );
    } else if (errorMessage.contains('network_error')) {
      return ApiErrorModel(
        message:
            'Network error during Google sign-in. Please check your connection.',
      );
    } else {
      return ApiErrorModel(message: 'Google Sign-In failed: $exceptionString');
    }
  }

  static ApiErrorModel _handleSupabaseAuthException(AuthException exception) {
    switch (exception.statusCode) {
      case '400':
        return ApiErrorModel(
          message: 'Invalid request. Please check your credentials.',
        );
      case '401':
        return ApiErrorModel(
          message: 'Authentication failed. Please try signing in again.',
        );
      case '403':
        return ApiErrorModel(
          message: 'Access denied. Your account may not have permission.',
        );
      case '422':
        return ApiErrorModel(
          message: 'Invalid token. Please try signing in again.',
        );
      case '429':
        return ApiErrorModel(
          message: 'Too many requests. Please wait a moment and try again.',
        );
      case '500':
        return ApiErrorModel(message: 'Server error. Please try again later.');
      default:
        return ApiErrorModel(
          message: 'Authentication error: ${exception.message}',
        );
    }
  }

  static ApiErrorModel _handlePlatformException(PlatformException exception) {
    switch (exception.code) {
      case 'sign_in_failed':
        return ApiErrorModel(
          message: 'Google Sign-In failed. Please try again.',
        );
      case 'sign_in_canceled':
        return ApiErrorModel(
          message: 'Sign-in was canceled. Please try again.',
        );
      case 'sign_in_required':
        return ApiErrorModel(
          message: 'Sign-in required. Please authenticate with Google.',
        );
      case 'network_error':
        return ApiErrorModel(
          message: 'Network error. Please check your connection and try again.',
        );
      case 'developer_error':
        return ApiErrorModel(
          message: 'Configuration error. Please contact support.',
        );
      default:
        return ApiErrorModel(
          message:
              'Platform error: ${exception.message ?? 'Unknown error occurred'}',
        );
    }
  }

  static ApiErrorModel _handleGenericException(exception) {
    final errorString = exception.toString().toLowerCase();

    if (errorString.contains('canceled')) {
      return ApiErrorModel(
        message: 'Operation was canceled. Please try again.',
      );
    } else if (errorString.contains('network') ||
        errorString.contains('connection')) {
      return ApiErrorModel(
        message: 'Network error. Please check your internet connection.',
      );
    } else if (errorString.contains('timeout')) {
      return ApiErrorModel(message: 'Request timed out. Please try again.');
    } else if (errorString.contains('token')) {
      return ApiErrorModel(
        message: 'Authentication token error. Please sign in again.',
      );
    } else if (errorString.contains('permission')) {
      return ApiErrorModel(
        message: 'Permission denied. Please grant necessary permissions.',
      );
    } else if (errorString.contains('configuration') ||
        errorString.contains('developer')) {
      return ApiErrorModel(
        message: 'Configuration error. Please contact support.',
      );
    } else {
      return ApiErrorModel(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}

ApiErrorModel _handleError(data) {
  // Handle API response errors
  return ApiErrorModel(
    message: "Server returned an error: ${data?.toString() ?? 'Unknown error'}",
  );
}
