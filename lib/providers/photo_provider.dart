import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/logger_service.dart';

class PhotoProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  bool _isLoading = false;

  XFile? get pickedImage => _pickedImage;
  bool get isLoading => _isLoading;

  // Method to pick image from camera
  Future<void> takePicture() async {
    try {
      _isLoading = true;
      notifyListeners();

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        _pickedImage = image;
        logger.info('Picture taken: ${image.path}');
      } else {
        logger.info('No image was selected');
      }
    } catch (e) {
      logger.error('Error taking picture: ${e.toString()}', error: e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      _isLoading = true;
      notifyListeners();

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        _pickedImage = image;
        logger.info('Image picked from gallery: ${image.path}');
      } else {
        logger.info('No image was selected');
      }
    } catch (e) {
      logger.error('Error picking image: ${e.toString()}', error: e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to show option dialog for camera or gallery
  Future<void> showImageSourceOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceOption(
                      context,
                      Icons.camera_alt,
                      'Camera',
                      () {
                        Navigator.pop(context);
                        takePicture();
                      },
                    ),
                    _buildImageSourceOption(
                      context,
                      Icons.photo_library,
                      'Gallery',
                      () {
                        Navigator.pop(context);
                        pickImageFromGallery();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to build image source option button
  Widget _buildImageSourceOption(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Method to clear the selected image
  void clearImage() {
    _pickedImage = null;
    notifyListeners();
  }
}