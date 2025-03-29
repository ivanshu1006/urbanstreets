import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/api_constants.dart';
import '../services/logger_service.dart';

class AuthRepository {
  final Dio _dio;
  AuthRepository(
    this._dio,
  );
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  // final Dio _dio = DioService().client;

  //LOGIN

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiConstants.loginEndpoint, data: {
        'email': email,
        'password': password,
      });
      log(response.toString(), name: 'Login Response');

      if (response.statusCode == 200) {
        logger.debug(response);
        return response;
       
      }
    } catch (e) {
      // Handle login error
      logger.error(
        'Login failed: ${e.toString()}',
        error: e,
      );
    }
    return null;
  }

  //REGISTER

  Future<bool> signup({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String mobileNumber,
  required String profilePicUrl,
  required String location,
  required double latitude,
  required double longitude,
  required String bio,
  required List<String> interests,
  required String gender,
  required String birthDate,
  required String idNumber,
  required String idPhotoUrl,
  bool isPremiumMember = false,
  bool isVerified = false,
}) async {
  try {
    final response = await _dio.post(ApiConstants.signupEndpoint, data: {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'profile_pic_url': profilePicUrl,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'bio': bio,
      'interests': interests,
      'gender': gender,
      'birth_date': birthDate,
      'id_number': idNumber,
      'id_photo_url': idPhotoUrl,
      'is_premium_member': isPremiumMember,
      'is_verified': isVerified,
    });
    log(response.toString(), name: 'Signup Response');
   

    if (response.statusCode == 201) {
      logger.debug(response);
      return true;
    }
  } catch (e) {
    // Handle signup error
    logger.error(
      'Signup failed: ${e.toString()}',
      error: e,
    );
  }
  return false;
}


  Future<void> logout() async {
    await secureStorage.delete(key: 'token');
  }

  
}
