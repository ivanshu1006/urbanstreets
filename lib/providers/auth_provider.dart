import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repositories/auth_repository.dart';
import '../services/dio_service.dart';
import '../services/logger_service.dart';

class AuthProvider with ChangeNotifier {
  static final AuthProvider _instance = AuthProvider._internal();
  factory AuthProvider() => _instance;
  AuthProvider._internal();

  final AuthRepository _frappeRepository = AuthRepository(DioService.instance.client);
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isLoggedIn = false;
  bool _passwordVisible = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get passwordVisible => _passwordVisible;

 Future<bool> login(String email, String password) async {
  try {
    final response = await _frappeRepository.login(email, password);
    log('Raw Response: $response', name: 'Login Raw Response');

    if (response == null) {
      logger.error('Login API returned null response');
      return false;
    }

    var data = jsonDecode(response.toString());
    log('Decoded Data: $data', name: 'Login Decoded Response');

    if (data.containsKey('token')) {
      String token = data['token'];
      int userid = data['id'];

      log('User ID: $userid', name: 'Login User ID');

      // Store token
      await _secureStorage.write(key: 'token', value: token);
      // Store userid
      await _secureStorage.write(key: 'userid', value: userid.toString());

      _isLoggedIn = true;
      notifyListeners();
      return true;
    } else {
      logger.error('Token not found in response: $data');
    }
  } catch (e) {
    logger.error('Login failed: ${e.toString()}', error: e);
  }
  return false;
}


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
      final success = await _frappeRepository.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        mobileNumber: mobileNumber,
        profilePicUrl: profilePicUrl,
        location: location,
        latitude: latitude,
        longitude: longitude,
        bio: bio,
        interests: interests,
        gender: gender,
        birthDate: birthDate,
        idNumber: idNumber,
        idPhotoUrl: idPhotoUrl,
      );
      
      if (success) {
        notifyListeners();
        return true;
      }
    } catch (e) {
      logger.error('Signup failed: ${e.toString()}', error: e);
      return false;
    }
    return false;
  }

  Future<void> logout() async {
    logger.info('Logging out');

    await _secureStorage.delete(key: 'token');
    await _frappeRepository.logout();
    
    _isLoggedIn = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }
}
