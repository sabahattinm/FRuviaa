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

class ErrorHandler {
  // Hata tiplerini belirle
  static String getErrorType(String error) {
    /// MODIFY CODE ONLY BELOW THIS LINE

    if (error.contains('SocketException') || error.contains('timeout')) {
      return 'network';
    } else if (error.contains('permission') || error.contains('izin')) {
      return 'permission';
    } else if (error.contains('dosya') || error.contains('file')) {
      return 'file';
    } else if (error.contains('500') || error.contains('server')) {
      return 'server';
    } else {
      return 'unknown';
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Kullanıcı dostu hata mesajı
  static String getUserFriendlyMessage(String error) {
    /// MODIFY CODE ONLY BELOW THIS LINE

    String errorType = getErrorType(error);

    switch (errorType) {
      case 'network':
        return 'İnternet bağlantınızı kontrol edin ve tekrar deneyin';
      case 'permission':
        return 'Uygulama izinlerini kontrol edin';
      case 'file':
        return 'Resim dosyası ile ilgili bir sorun var';
      case 'server':
        return 'Sunucu şu anda müsait değil, lütfen daha sonra deneyin';
      default:
        return 'Beklenmeyen bir hata oluştu, lütfen tekrar deneyin';
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }

  // Hata durumunda önerilen aksiyonlar
  static List<String> getSuggestedActions(String error) {
    /// MODIFY CODE ONLY BELOW THIS LINE

    String errorType = getErrorType(error);

    switch (errorType) {
      case 'network':
        return [
          'WiFi veya mobil verilerinizi kontrol edin',
          'Uçak modunu açıp kapatmayı deneyin',
          'Birkaç dakika sonra tekrar deneyin'
        ];
      case 'permission':
        return [
          'Ayarlar > Uygulamalar > İzinler kısmını kontrol edin',
          'Kamera ve depolama izinlerini etkinleştirin'
        ];
      case 'file':
        return [
          'Farklı bir resim seçmeyi deneyin',
          'Resmin çok büyük olmadığından emin olun'
        ];
      case 'server':
        return [
          'Birkaç dakika sonra tekrar deneyin',
          'Uygulama güncellemesi olup olmadığını kontrol edin'
        ];
      default:
        return [
          'Uygulamayı yeniden başlatmayı deneyin',
          'Teknik destek ile iletişime geçin'
        ];
    }

    /// MODIFY CODE ONLY ABOVE THIS LINE
  }
}
