import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fruvia/app_state.dart';
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

// Additional imports for API functionality
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FruitAnalyzerService {
  // Ana analiz fonksiyonu
  static Future<Map<String, dynamic>> analyzeFruitImage(
      String imagePath) async {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      // App State'den API URL'i al
      String baseUrl = FFAppState().apiBaseUrl.isNotEmpty
          ? FFAppState().apiBaseUrl
          : "https://your-api-url.com";

      // Loading state'i aktif et
      FFAppState().update(() {
        FFAppState().isAnalyzing = true;
        FFAppState().hasError = false;
        FFAppState().lastError = "";
      });

      File imageFile = File(imagePath);

      // Dosya kontrolü
      if (!await imageFile.exists()) {
        throw Exception('Seçilen resim dosyası bulunamadı');
      }

      // Dosya boyutu kontrolü (5MB limit)
      int fileSizeInBytes = await imageFile.length();
      if (fileSizeInBytes > 5 * 1024 * 1024) {
        throw Exception('Resim dosyası çok büyük (Max: 5MB)');
      }

      // HTTP request oluştur
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/analyze_fruits_vegetables'),
      );

      // Resim dosyasını ekle
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imagePath,
          filename: 'fruit_image.jpg',
        ),
      );

      // Headers ekle
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp/1.0',
      });

      // Request gönder (30 saniye timeout)
      var streamedResponse = await request.send().timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw Exception('İstek zaman aşımına uğradı');
        },
      );

      var response = await http.Response.fromStream(streamedResponse);

      // Response kontrolü
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Base64 image'ı Uint8List'e çevir
        String base64Image = jsonResponse['marked_image'] ?? '';
        Uint8List? imageBytes = _base64ToBytes(base64Image);

        if (imageBytes != null) {
          // App State'i güncelle
          FFAppState().update(() {
            FFAppState().analyzedImageBytes = imageBytes;
            FFAppState().nutritionInfo = jsonResponse['nutrition_info'] ?? '';
            FFAppState().analysisComplete = true;
          });
        }

        return {
          'success': true,
          'imageBytes': imageBytes,
          'nutritionInfo': jsonResponse['nutrition_info'] ?? '',
          'message': 'Analiz başarıyla tamamlandı'
        };
      } else {
        String errorMessage = 'Sunucu hatası: ${response.statusCode}';
        if (response.body.isNotEmpty) {
          try {
            var errorJson = json.decode(response.body);
            errorMessage = errorJson['detail'] ?? errorMessage;
          } catch (e) {
            // JSON parse hatası, default mesajı kullan
          }
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Hata durumunu kaydet
      FFAppState().update(() {
        FFAppState().hasError = true;
        FFAppState().lastError = e.toString();
      });

      return {
        'success': false,
        'error': e.toString(),
        'message': 'Analiz sırasında hata oluştu'
      };
    } finally {
      // Loading state'i kapat
      FFAppState().update(() {
        FFAppState().isAnalyzing = false;
      });
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Base64'ü Uint8List'e çevir
  static Uint8List? _base64ToBytes(String base64String) {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      // "data:image/jpeg;base64," kısmını temizle
      String cleanBase64 = base64String.contains(',')
          ? base64String.split(',').last
          : base64String;

      return base64Decode(cleanBase64);
    } catch (e) {
      print('Base64 decode error: $e');
      return null;
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Network bağlantısı kontrolü
  static Future<bool> checkInternetConnection() async {
    /// MODIFY CODE ONLY BELOW THIS LINE

    try {
      String baseUrl = FFAppState().apiBaseUrl.isNotEmpty
          ? FFAppState().apiBaseUrl
          : "https://your-api-url.com";

      final result = await http
          .get(
            Uri.parse('$baseUrl/health'),
          )
          .timeout(Duration(seconds: 5));

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }
}
