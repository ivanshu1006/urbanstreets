import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/core/barrel_file.dart';
import '../repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  static final ProfileProvider _instance = ProfileProvider._internal();
  factory ProfileProvider() => _instance;

  ProfileProvider._internal();

  final ProfileRepository _profileRepository = ProfileRepository();

  bool isLoading = false;
  String? kycResponse;
   dynamic communityResponse;
   dynamic? errorMessage;

   List<Map<String, dynamic>> events = [];

  Future<void> applyKyc(String idNumber, int businessId) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _profileRepository.applyKyc(idNumber,businessId);

      kycResponse = response.toString();
      log('KYC Response: $kycResponse', name: 'ProfileProvider');

    } catch (e) {
      log('Error applying KYC: $e', name: 'ProfileProvider');
      kycResponse = "Failed to apply KYC";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
Future<void> createCommunity({
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
  isLoading = true;
  notifyListeners();

  try {
    final response = await _profileRepository.createCommunity(
      adminId: adminId,
      communityName: communityName,
      communityEmail: communityEmail,
      communityMobileNumber: communityMobileNumber,
      communityCategory: communityCategory,
      communityAddress: communityAddress,
      communityDescription: communityDescription,
      members: members,
      coverPhotoUrl: coverPhotoUrl,
    );

    log(response.runtimeType.toString());

    if (response != null && response is Map<String, dynamic>) {
      final String message = response['message'] ?? "Community created successfully!";
      log("Create Community Response: $message");
      SnackbarGlobal.show(message);
    } else {
      errorMessage = "Failed to create community.";
      SnackbarGlobal.show(errorMessage);
    }
  } catch (e) {
    errorMessage = e.toString();
    SnackbarGlobal.show(errorMessage);
  }

  isLoading = false;
  notifyListeners();
}


Future<void> fetchEvents() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _profileRepository.getEvents();
      events = response; // Store the events
      log(events.toString(), name: 'Fetched Events');
    } catch (e) {
      errorMessage = e.toString();
      SnackbarGlobal.show(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

    //create an event
  Future<void> createEvent({
    required int communityId,
    required String title,
    required String description,
    required String coverBannerUrl,
    required String date,
    required String time,
    required List<String> speakers,
    required double entryFee,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _profileRepository.createEvent(
        communityId: communityId,
        title: title,
        description: description,
        coverBannerUrl: coverBannerUrl,
        date: date,
        time: time,
        speakers: speakers,
        entryFee: entryFee,
      );

      if (response != null) {
        log('Event created successfully', name: 'ProfileProvider');
        SnackbarGlobal.show('Event created successfully');
      } else {
        SnackbarGlobal.show('Failed to create event');
      }
    } catch (e) {
      errorMessage = e.toString();
      SnackbarGlobal.show(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
