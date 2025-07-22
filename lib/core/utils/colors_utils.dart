import 'package:flutter/material.dart';

class ColorUtils {
  static Color getTextColorForBackground(String hexColor) {
    String cleaned =
        hexColor.replaceAll('#', '').replaceAll('0x', '').toUpperCase().trim();
    if (cleaned.length == 6) {
      cleaned = 'FF$cleaned';
    }
    if (cleaned.length != 8) {
      throw FormatException(
        "El color hexadecimal debe tener exactamente 6 u 8 caracteres: '$hexColor'",
      );
    }
    final color = Color(int.parse(cleaned, radix: 16));
    int r = color.red;
    int g = color.green;
    int b = color.blue;
    double luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  static Color fromHex(String hexString) {
    String cleaned = hexString
        .replaceAll('#', '')
        .replaceAll('0x', '')
        .replaceAll('0X', '')
        .trim()
        .toUpperCase();
    if (cleaned.length == 6) {
      cleaned = 'FF$cleaned';
    }
    if (cleaned.length != 8) {
      throw FormatException(
        "ColorUtils.fromHex: El color hexadecimal debe tener 6 (RRGGBB) o 8 (AARRGGBB) dígitos: '$hexString' (después de limpiar: '$cleaned')",
      );
    }
    try {
      return Color(int.parse(cleaned, radix: 16));
    } catch (e) {
      throw FormatException(
        "ColorUtils.fromHex: El string '$hexString' no pudo convertirse en Color. Detalle: $e",
      );
    }
  }
}
