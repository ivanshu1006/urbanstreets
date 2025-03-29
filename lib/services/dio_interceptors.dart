
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/auth_provider.dart';
import '../widgets/snack_bar.dart';

class DioInterceptors extends InterceptorsWrapper {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Log request details 📡
    log("\n🟡 [API REQUEST] → ${options.method} ${options.baseUrl}${options.path}");
    log("📩 [HEADERS]: ${options.headers}");
    log("📤 [BODY]: ${options.data ?? "No Body"}");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // Log successful response ✅
    print("\n🟢 [API RESPONSE] ← ${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}");
    print("📜 [STATUS CODE]: ${response.statusCode}");
    print("📥 [RESPONSE]: ${response.data}");

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Log API error ❌
    log("\n🔴 [API ERROR] ❗ ${err.requestOptions.method} ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    log("🚨 [STATUS CODE]: ${err.response?.statusCode ?? "Unknown"}");
    log("📩 [HEADERS]: ${err.requestOptions.headers}");
    log("📤 [BODY]: ${err.requestOptions.data ?? "No Body"}");
    log("📥 [ERROR RESPONSE]: ${err.response?.data ?? "No Response Data"}");

    // Handle error messages in Snackbar
    String errorMessage = "⚠️ An unknown error occurred.";
    
    if (err.response?.statusCode == 401) {
      errorMessage = "🔐 Incorrect username/password.";
    } else if (err.response?.statusCode == 403) {
      try {
        final response = err.response?.data;
        final loginProvider = AuthProvider();
        if (response['session_expired'] == 1) {
          errorMessage = "⏳ Session Expired. Please log in again.";
          loginProvider.logout();
        } else {
          errorMessage = "⛔ Forbidden access.";
        }
      } catch (e) {
        errorMessage = "⚠️ Error processing server response.";
      }
    } else if (err.response?.statusCode == 404) {
      errorMessage = "🔍 Page not found.";
    } else if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = "⏱️ Connection timeout. Please try again.";
    } else if (err.type == DioExceptionType.badResponse) {
      errorMessage = "⚠️ Received a bad response from the server.";
    } else if (err.type == DioExceptionType.cancel) {
      errorMessage = "🚫 Request was cancelled.";
    } else {
      if (err.error.toString().contains('SocketException')) {
        errorMessage = "🌐 Please check your internet connection.";
      } else {
        errorMessage = "❗ Unknown Error: ${err.error.toString()}";
      }
    }

    // Show Snackbar with the error message
    SnackbarGlobal.show(
      errorMessage,
      textColor: Colors.white,
      backgroundColor: Colors.red,
    );

    super.onError(err, handler);
  }
}
