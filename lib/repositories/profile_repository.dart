import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';
import '../services/logger_service.dart';

class ProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._internal();
  factory ProfileRepository() => _instance;

  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ProfileRepository._internal();

  Future<String?> applyKyc(String idNumber, int businessId) async {
    try {
      String? userIdString = await _secureStorage.read(key: 'userid');

      if (userIdString == null) {
        log('User ID not found in storage', name: 'ProfileRepository');
        return "User id not found";
      }

      int userId = int.parse(userIdString);
      log(userId.toString(), name: 'User ID');

      final response =
          await _dio.post('${ApiConstants.kycEndPoint}/apply', data: {
        "userId": 1,
        "kycData": {
          "id_number": idNumber,
          "document_url": 'https://example.com/kyc-doc.pdf',
          "business_id": businessId
        }
      });
      print('-----------------------------------');
      print(response);
      log(response.toString(), name: 'User Posts Response');
      if (response.statusCode == 200) {
        return response.data;
      }
      return response.data;
    } catch (e, t) {
      logger.error('Fetching kyc failed: ${e.toString()}', error: e);
      log(t.toString(), name: 'kyc profile repo');
    }
  }

  Future<dynamic> createCommunity({
    required int adminId,
    required String communityName,
    required String communityEmail,
    required String communityMobileNumber,
    required String communityCategory,
    required String communityAddress,
    required String communityDescription,
    required int members,
    required String coverPhotoUrl,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}api/communities',
        data: {
          "admin_id": adminId,
          "community_name": communityName,
          "community_email": communityEmail,
          "community_mobile_number": communityMobileNumber,
          "community_category": communityCategory,
          "community_address": communityAddress,
          "community_description": communityDescription,
          "members": members,
          "cover_photo_url": coverPhotoUrl
        },
      );

      log(response.toString(), name: 'Create Community Response');

      if (response.statusCode == 201) {
        log(response.statusCode.toString());
        log(response.runtimeType.toString());
        return response.data;
      }
      return response.data;
    } catch (e, t) {
      logger.error('Creating community failed: ${e.toString()}', error: e);
      log(t.toString(), name: 'createCommunity Error');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}api/events');

      log(response.toString(), name: 'Get Events Response');

      if (response.statusCode == 200) {
        // Ensure the response data is a list of maps
        List<dynamic> responseData = response.data;
        return responseData.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e, t) {
      logger.error('Fetching events failed: ${e.toString()}', error: e);
      log(t.toString(), name: 'getEvents Error');
      return [];
    }
  }

  Future<dynamic> createEvent({
    required int communityId,
    required String title,
    required String description,
    required String coverBannerUrl,
    required String date,
    required String time,
    required List<String> speakers,
    required double entryFee,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}api/events',
        data: {
          "community_id": communityId,
          "title": title,
          "description": description,
          "cover_banner_url": coverBannerUrl,
          "date": date,
          "time": time,
          "speakers": speakers,
          "entry_fee": entryFee,
        },
      );

      log(response.toString(), name: 'Create Event Response');

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create event');
      }
    } catch (e, t) {
      logger.error('Creating event failed: ${e.toString()}', error: e);
      log(t.toString(), name: 'createEvent Error');
      return null;
    }
  }
}
