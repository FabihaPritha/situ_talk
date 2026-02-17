import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppHelperFunctions {
  AppHelperFunctions._();
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Modern image picker using Android Photo Picker API
  /// No storage permissions required for gallery
  /// Only camera permission needed for camera capture
  static Future<XFile?> showImageSourceDialog() async {
    try {
      return await Get.bottomSheet<XFile>(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () async {
                  try {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 85,
                      maxWidth: 1920,
                      maxHeight: 1920,
                    );
                    Get.back(result: pickedFile);
                  } catch (e) {
                    Get.back();
                    showSnackBar('Failed to access camera: ${e.toString()}');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                // subtitle: const Text(
                //   "No storage permission required",
                //   style: TextStyle(fontSize: 12, color: Colors.grey),
                // ),
                onTap: () async {
                  try {
                    // Uses Android Photo Picker API (Android 11+)
                    // No storage permission needed
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 85,
                      maxWidth: 1920,
                      maxHeight: 1920,
                    );
                    Get.back(result: pickedFile);
                  } catch (e) {
                    Get.back();
                    showSnackBar('Failed to access gallery: ${e.toString()}');
                  }
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      showSnackBar('Error opening image picker: ${e.toString()}');
      return null;
    }
  }

  /// Pick multiple images from gallery using Android Photo Picker
  /// No storage permissions required
  static Future<List<XFile>?> pickMultipleImages() async {
    try {
      final List<XFile> images = await ImagePicker().pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (images.isEmpty) {
        return null;
      }

      return images;
    } catch (e) {
      showSnackBar('Failed to pick images: ${e.toString()}');
      return null;
    }
  }

  /// Pick single image directly from camera
  static Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image;
    } catch (e) {
      showSnackBar('Failed to access camera: ${e.toString()}');
      return null;
    }
  }

  /// Pick single image directly from gallery
  static Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      return image;
    } catch (e) {
      showSnackBar('Failed to access gallery: ${e.toString()}');
      return null;
    }
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String formatBlockedDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds second${seconds > 1 ? 's' : ''}';
    } else if (seconds < 3600) {
      final minutes = seconds ~/ 60;
      return '$minutes minute${minutes > 1 ? 's' : ''}';
    } else if (seconds < 86400) {
      final hours = seconds ~/ 3600;
      return '$hours hour${hours > 1 ? 's' : ''}';
    } else {
      final days = seconds ~/ 86400;
      return '$days day${days > 1 ? 's' : ''}';
    }
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
