import 'package:flutter/services.dart';

class CardTypeDetector {
  static String detectType(String cardNumber) {
    final cleaned = cardNumber.replaceAll(' ', '');
    if (cleaned.isEmpty) return '';
    if (cleaned.startsWith('4')) return 'VISA';
    if (cleaned.startsWith('5')) return 'MASTERCARD';
    if (cleaned.startsWith('34') ||
        cleaned.startsWith('35') ||
        cleaned.startsWith('36') ||
        cleaned.startsWith('37')) {
      return 'AMEX';
    }
    if (cleaned.startsWith('6')) return 'DISCOVER';
    if (cleaned.startsWith('35')) return 'JCB';
    if (cleaned.startsWith('30') || cleaned.startsWith('38')) return 'DINERS';
    return 'OTRO';
  }
}
