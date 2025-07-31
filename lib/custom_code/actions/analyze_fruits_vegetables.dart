// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import '/backend/sqlite/sqlite_manager.dart'; // SQLite hatası varsa bu satırı comment out edin

import 'dart:convert';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';

import '/auth/supabase_auth/auth_util.dart';

// Additional imports
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

// Resim küçültme fonksiyonu
Uint8List compressImageIfNeeded(Uint8List bytes) {
  try {
    // Eğer 2MB'dan küçükse dokunma
    if (bytes.length <= 2 * 1024 * 1024) {
      return bytes;
    }

    print(
        'Resim sıkıştırılıyor... Orijinal boyut: ${(bytes.length / 1024 / 1024).toStringAsFixed(2)} MB');

    // Resmi decode et
    final image = img.decodeImage(bytes);
    if (image == null) {
      print('Resim decode edilemedi, orijinal döndürülüyor');
      return bytes;
    }

    // Boyutları kontrol et ve küçült
    int newWidth = image.width;
    int newHeight = image.height;

    print('Orijinal boyutlar: ${image.width}x${image.height}');

    // Max 1024px yaparak küçült
    if (image.width > 1024 || image.height > 1024) {
      if (image.width > image.height) {
        newWidth = 1024;
        newHeight = (image.height * 1024 / image.width).round();
      } else {
        newHeight = 1024;
        newWidth = (image.width * 1024 / image.height).round();
      }
      print('Yeni boyutlar: ${newWidth}x${newHeight}');
    }

    // Resmi yeniden boyutlandır
    final resized = img.copyResize(image, width: newWidth, height: newHeight);

    // JPEG olarak sıkıştır (kalite 80)
    final compressed = img.encodeJpg(resized, quality: 80);
    final compressedBytes = Uint8List.fromList(compressed);

    print(
        'Sıkıştırma tamamlandı. Yeni boyut: ${(compressedBytes.length / 1024 / 1024).toStringAsFixed(2)} MB');

    return compressedBytes;
  } catch (e) {
    print('Resim sıkıştırma hatası: $e');
    return bytes; // Hata durumunda orijinali döndür
  }
}

Future<void> analyzeFruitsVegetables(
    FFUploadedFile imageFile, String apiBaseUrl) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  try {
    // API URL belirleme - conditional yerine direkt kullan
    final String baseUrl =
        apiBaseUrl.isNotEmpty ? apiBaseUrl : FFAppState().apiBaseUrl;

    // Eğer hala boş ise default değer ata
    if (baseUrl.isEmpty) {
      throw Exception('API URL tanımlanmamış');
    }

    // Loading state başlat
    FFAppState().update(() {
      FFAppState().isAnalyzing = true;
      FFAppState().hasError = false;
      FFAppState().lastError = "Resim optimize ediliyor...";
      FFAppState().analysisComplete = false;
    });

    // FFUploadedFile'dan File oluştur
    if (imageFile.bytes == null || imageFile.bytes!.isEmpty) {
      throw Exception('Geçersiz resim dosyası');
    }

    // Resmi otomatik küçült (gerekirse)
    FFAppState().update(() {
      FFAppState().lastError = "Resim işleniyor...";
    });

    final Uint8List processedImageBytes =
        compressImageIfNeeded(imageFile.bytes!);

    // İşlenmiş dosya boyutu kontrolü
    if (processedImageBytes.length > 5 * 1024 * 1024) {
      throw Exception('Resim sıkıştırıldıktan sonra bile çok büyük (Max: 5MB)');
    }

    // Loading mesajını güncelle
    FFAppState().update(() {
      FFAppState().lastError =
          "Resim analiz ediliyor... (Bu 1-2 dakika sürebilir)";
    });

    // HTTP client oluştur
    final client = http.Client();

    try {
      // HTTP request oluştur
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/analyze_fruits_vegetables'),
      );

      // İşlenmiş resim dosyasını ekle
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          processedImageBytes,
          filename: imageFile.name ?? 'fruit_image.jpg',
        ),
      );

      // Headers ekle
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp/1.0',
      });

      // Request gönder (2 dakika timeout)
      final streamedResponse = await client.send(request).timeout(
        const Duration(seconds: 120),
        onTimeout: () {
          throw Exception('Analiz çok uzun sürüyor, lütfen tekrar deneyin');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);

      // Response işleme
      if (response.statusCode != 200) {
        String errorMessage = 'Sunucu hatası: ${response.statusCode}';

        if (response.body.isNotEmpty) {
          try {
            final errorJson = json.decode(response.body);
            errorMessage = errorJson['detail'] ?? errorMessage;
          } catch (e) {
            // JSON parse hatası durumunda default mesaj kullan
          }
        }
        throw Exception(errorMessage);
      }

      // Başarılı response işleme
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final String base64Image = jsonResponse['marked_image'] ?? '';

      // Base64 string'i temizle (data: prefix'i varsa kaldır)
      String cleanBase64 = '';
      if (base64Image.isNotEmpty) {
        try {
          cleanBase64 = base64Image.contains(',')
              ? base64Image.split(',').last
              : base64Image;
        } catch (e) {
          print('Base64 clean error: $e');
          cleanBase64 = base64Image; // Hata durumunda orijinali kullan
        }
      }

      // App State güncelleme - başarılı durumda
      FFAppState().update(() {
        FFAppState().analyzedImageBytes = base64Image.contains('data:image')
            ? base64Image
            : 'data:image/png;base64,$base64Image';
        FFAppState().nutritionInfo = jsonResponse['nutrition_info'] ?? '';
        FFAppState().analysisComplete = true;
        FFAppState().hasError = false;
        FFAppState().lastError = "";
      });
    } finally {
      // HTTP client'ı kapat
      client.close();
    }
  } catch (e) {
    // Hata durumu - App State güncelleme
    FFAppState().update(() {
      FFAppState().hasError = true;
      FFAppState().lastError = e.toString();
      FFAppState().analysisComplete = false;
      FFAppState().analyzedImageBytes = "";
      FFAppState().nutritionInfo = "";
    });

    // Hata logla
    print('analyzeFruitsVegetables error: ${e.toString()}');
  } finally {
    // Her durumda loading'i kapat
    FFAppState().update(() {
      FFAppState().isAnalyzing = false;
    });
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
