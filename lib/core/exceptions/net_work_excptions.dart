import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/helper_fuctions/snack_bar.dart';
import 'app_exceptions.dart';
import 'package:http/http.dart' as http;


class TimeoutExceptionCustom extends AppException {
  TimeoutExceptionCustom() : super("⏳ Request timeout. Please try again later.");
}


class NoInternetException extends AppException {
  NoInternetException() : super("🌐 No internet connection. Please check your network.");
}


class ServerException extends AppException {
  ServerException() : super("❌ Server error. Please try again later.");
}


class UnknownException extends AppException {
  UnknownException(dynamic error) : super("❌ Unexpected error: $error");
}

class PlatformException extends AppException {
  PlatformException() : super("📱 A platform error occurred. Please restart the app.");
}

class InvalidFormatException extends AppException {
  InvalidFormatException() : super("📂 Invalid format. Please check your input.");
}

class ApiException extends AppException {
  ApiException(String message) : super("⚠️ API Error: $message");
}

class AuthExceptionCustom extends AppException {
  AuthExceptionCustom(String message) : super("🔐 Auth Error: $message");
}


class ExceptionHandler {

  static void handle(dynamic error, BuildContext context, {String tag = "General"}) {
    String errorMessage = getMessage(error);
    debugPrint("⚠️ Exception in [$tag]: $errorMessage");
    debugPrint("StackTrace: ${error is Error ? error.stackTrace : 'No stack trace'}");
    if (context.mounted) {
      SnackBarClass.errorSnackBar(context: context, message: errorMessage);
    }
  }

  static String getMessage(dynamic error) {
    if (error is TimeoutException) {
      return TimeoutExceptionCustom().message;
    } else if (error is SocketException || error.toString().contains('SocketException')) {
      return NoInternetException().message;
    } else if (error is HttpException) {
      return ServerException().message;
    } else if (error is FormatException) {
      return InvalidFormatException().message;
    }  else if (error.toString().contains('AuthException') && error.toString().contains('invalid_credentials')) {
      return AuthExceptionCustom("Invalid login credentials").message;
    }else if (error.toString().contains('email_address_invalid') && error.toString().contains('email_address_invalid')) {
      return AuthExceptionCustom("Invalid Email ").message;
    } else if (error is PlatformException) {
      return "A platform error occurred: ${error.message}";
    } else if (error is ApiException) {
      return error.message;
    } else if (error is AppException) {
      return error.message;
    }else {
      return UnknownException(error).message;
    }
  }

  static void handleApiResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      throw ApiException("Server responded with status code ${response.statusCode} and response body ${response.body.toString()}");
    } else {
      throw ApiException("Server responded with status code ${response.statusCode} and response body ${response.body.toString()}");
    }
  }
}





