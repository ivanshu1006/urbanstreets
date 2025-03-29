import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import 'package:frappe_flutter_app/model/posts_section_models/get_user_post_model.dart';
import 'package:frappe_flutter_app/model/posts_section_models/profile_section_models/getUserDataModel.dart';
import 'package:frappe_flutter_app/model/posts_section_models/profile_section_models/get_comment_data_model.dart';
import '../constants/api_constants.dart';
import '../services/logger_service.dart';

class PostRepository {
  static final PostRepository _instance = PostRepository._internal();
  factory PostRepository() => _instance;

  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  PostRepository._internal();

  Future<List<GetUserPostsModel>> getUserPosts() async {
    try {
      String? userIdString = await _secureStorage.read(key: 'userid');

      if (userIdString == null) {
        log('User ID not found in storage', name: 'PostRepository');
        return [];
      }

      int userId = int.parse(userIdString);
      log(userId.toString(), name: 'User ID');

      final response = await _dio.get('${ApiConstants.baseUrl}api/posts/user/1');
      log(response.toString(), name: 'User Posts Response');

      if (response.statusCode == 200) {
        List<dynamic> postData = response.data;
        return postData
            .map((json) => GetUserPostsModel.fromJson(json))
            .toList();
      }
    } catch (e, t) {
      logger.error('Fetching posts failed: ${e.toString()}', error: e);
      log(t.toString(), name: 'PostRepository');
    }
    return [];
  }

  Future<GetUserDataModel?> getUserProfileData() async {
    try {
      String? userIdString = await _secureStorage.read(key: 'userid');

      if (userIdString == null) {
        log('User ID not found in storage', name: 'PostRepository');
        return null;
      }

      int userId = int.parse(userIdString);
      final response = await _dio.get('${ApiConstants.baseUrl}api/users/1');

      if (response.statusCode == 200) {
        return GetUserDataModel.fromJson(response.data);
      }
    } catch (e, t) {
      logger.error('Fetching user profile failed: ${e.toString()}', error: e);
      log(t.toString(), name: 'PostRepository');
    }
    return null;
  }

  //LIKE POST

  Future<bool> likePost({required int userId, required int postId}) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}api/likes',
        data: {
          "user_id": userId,
          "post_id": postId,
        },
      );

      log('Like Post Response: ${response.data}', name: 'PostRepository');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; 
      }
    } catch (e, stackTrace) {
      log('Liking post failed: $e', name: 'PostRepository');
      log(stackTrace.toString(), name: 'PostRepository');
    }
    return false; 
  }

//CHECK POST IS LIKED OR NOT

  Future<bool> checkIfPostLiked(
      {required int userId, required int postId}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}api/likes/check/$userId/$postId',
      );

      log('Check Like Status Response: ${response.data}',
          name: 'PostRepository');

      if (response.statusCode == 200) {
        return response.data['liked'] == true;
      }
    } catch (e, stackTrace) {
      log('Checking like status failed: $e', name: 'PostRepository');
      log(stackTrace.toString(), name: 'PostRepository');
    }
    return false; 
  }

  // ADD COMMENT

  Future<bool> postComment({
    required int userId,
    required int postId,
    required String commentText,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}api/comments',
        data: {
          "user_id": userId,
          "post_id": postId,
          "comment_text": commentText,
        },
      );

      log('Post Comment Response: ${response.data}', name: 'PostRepository');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e, stackTrace) {
      log('Posting comment failed: $e', name: 'PostRepository');
      log(stackTrace.toString(), name: 'PostRepository');
      return false;
    }
  }

  //FETCH COMMENTS

  // Fetch comments for a specific post
  Future<List<Comment>> fetchComments(int postId) async {
    try {
      final response =
          await _dio.get('${ApiConstants.baseUrl}api/comments/$postId');

      if (response.statusCode == 200) {
        List<dynamic> commentsJson = response.data['comments'];
        return commentsJson.map((json) => Comment.fromJson(json)).toList();
      }
    } catch (e) {
      print('Fetching comments failed: $e');
    }
    return [];
  }

  // FOLLOW USER

  Future<bool> followUser(int followerId, int followingId) async {
    try {
      final requestBody = {
        'follower_id': followerId,
        'following_id': followingId,
      };

      log("🔵 Sending API Request to: ${ApiConstants.baseUrl}api/follow");
      log("📤 Request Body: $requestBody");

      final response = await _dio.post(
        '${ApiConstants.baseUrl}/api/follow',
        data: requestBody,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      log("🟢 Response Status Code: ${response.statusCode}");
      log("📥 Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        SnackbarGlobal.show("✅ Follow request successful!");
        return true;
      } else {
        SnackbarGlobal.show("⚠️ Follow request failed: ${response.data}");
        return false;
      }
    } catch (e, stackTrace) {
      log('🔴 Follow failed: $e');
      log('🔴 Stack Trace: $stackTrace');

      String errorMessage = "❌ Something went wrong!";

      if (e is DioException) {
        final errorData = e.response?.data;
        final statusCode = e.response?.statusCode;
        errorMessage =
            "🔴 Error ${statusCode ?? 'Unknown'}: ${errorData ?? e.message}";
        log("🔴 Error Response Data: $errorData");
        log("🔴 Error Status Code: $statusCode");
      } else {
        errorMessage = e.toString();
      }

      SnackbarGlobal.show(errorMessage);
    }
    return false;
  }
}
