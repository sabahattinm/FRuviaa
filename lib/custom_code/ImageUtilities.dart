import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/auth/supabase_auth/auth_util.dart';

// Additional imports
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtilities {
  static final ImagePicker _picker = ImagePicker();

  // Kameradan resim çek
  static Future<Map<String, dynamic>> captureFromCamera() async {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      // Kamera izni kontrolü
      PermissionStatus cameraPermission = await Permission.camera.request();
      if (!cameraPermission.isGranted) {
        return {
          'success': false,
          'error': 'Kamera izni gereklidir',
          'needsPermission': true
        };
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image == null) {
        return {
          'success': false,
          'error': 'Resim çekilmedi',
          'cancelled': true
        };
      }

      // Resmi optimize et
      String optimizedPath = await _optimizeImage(image.path);

      return {
        'success': true,
        'imagePath': optimizedPath,
        'originalPath': image.path
      };
    } catch (e) {
      return {'success': false, 'error': 'Kamera hatası: ${e.toString()}'};
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Galeriden resim seç
  static Future<Map<String, dynamic>> pickFromGallery() async {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      // Galeri izni kontrolü
      PermissionStatus storagePermission = await Permission.photos.request();
      if (!storagePermission.isGranted) {
        return {
          'success': false,
          'error': 'Galeri erişim izni gereklidir',
          'needsPermission': true
        };
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image == null) {
        return {
          'success': false,
          'error': 'Resim seçilmedi',
          'cancelled': true
        };
      }

      // Resmi optimize et
      String optimizedPath = await _optimizeImage(image.path);

      return {
        'success': true,
        'imagePath': optimizedPath,
        'originalPath': image.path
      };
    } catch (e) {
      return {'success': false, 'error': 'Galeri hatası: ${e.toString()}'};
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Resmi optimize et
  static Future<String> _optimizeImage(String imagePath) async {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      File imageFile = File(imagePath);
      Uint8List imageBytes = await imageFile.readAsBytes();

      // Image decode
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return imagePath;

      // Boyut kontrolü ve resize
      if (image.width > 1024 || image.height > 1024) {
        image = img.copyResize(
          image,
          width: image.width > image.height ? 1024 : null,
          height: image.height > image.width ? 1024 : null,
        );
      }

      // JPEG olarak encode (kalite: 85)
      List<int> optimizedBytes = img.encodeJpg(image, quality: 85);

      // Optimize edilmiş resmi kaydet
      Directory tempDir = await getTemporaryDirectory();
      String optimizedPath =
          '${tempDir.path}/optimized_${DateTime.now().millisecondsSinceEpoch}.jpg';

      File optimizedFile = File(optimizedPath);
      await optimizedFile.writeAsBytes(optimizedBytes);

      return optimizedPath;
    } catch (e) {
      print('Image optimization error: $e');
      return imagePath; // Hata durumunda orijinal path'i döndür
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Beslenme bilgisini formatla
  static String formatNutritionInfo(String rawInfo) {
    /// MODIFY CODE ONLY BELOW THIS LINE

    if (rawInfo.isEmpty) return 'Beslenme bilgisi bulunamadı';

    return rawInfo.replaceAll('\\n', '\n').replaceAll('  ', ' ').trim();

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Geçici dosyaları temizle
  static Future<void> clearTempFiles() async {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      Directory tempDir = await getTemporaryDirectory();
      List<FileSystemEntity> files = tempDir.listSync();

      for (FileSystemEntity file in files) {
        if (file.path.contains('optimized_') ||
            file.path.contains('image_picker')) {
          await file.delete();
        }
      }
    } catch (e) {
      print('Temp file cleanup error: $e');
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }
}
