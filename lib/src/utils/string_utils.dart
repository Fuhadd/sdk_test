import 'package:intl/intl.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';

class StringUtils {
  static String getBaseUrl({bool useV2Url = false}) {
    return useV2Url == false
        ? 'https://staging.api.mycover.ai/v1'
        : 'https://staging.api.mycover.ai/v2';
  }

  static String getProviderPeriodOfCover(String periodOfCover) {
    return periodOfCover == "12" ? "Anumm" : "Month";
  }

  static String getProductPrice(String price, bool isDynamic) {
    return isDynamic
        ? "${formatDynamicPrice(price)}%"
        : "₦ ${formatPriceWithComma(price)} ";
  }

  static String formatDynamicPrice(String priceString) {
    double price = double.tryParse(priceString) ?? 0.0;
    String formattedPrice = price.toStringAsFixed(2);

    if (formattedPrice.endsWith('.00')) {
      return formattedPrice.substring(
          0, formattedPrice.length - 3); // Remove the '.00'
    } else {
      return formattedPrice;
    }
  }

  static String? formatPriceWithComma(String? priceString) {
    if (priceString == null) {
      return null;
    } else {
      double price = double.tryParse(priceString) ?? 0.0;
      String formattedPrice = price.toStringAsFixed(2);

      if (formattedPrice.endsWith('.00')) {
        formattedPrice = formattedPrice.substring(
            0, formattedPrice.length - 3); // Remove the '.00'
      }

      return NumberFormat.currency(
              locale: 'en_US', decimalDigits: 0, symbol: '')
          .format(double.parse(formattedPrice));
    }
  }

  static String? getInitialValue(String name) {
    switch (name.toLowerCase()) {
      case 'email':
        return Global.form['email'] ?? '';
      case 'first_name':
        return Global.form['first_name'] ?? '';
      case 'last_name':
        return Global.form['last_name'] ?? '';
      case 'phone':
        return Global.form['phone'] ?? '';
      case 'phone_number':
        return Global.form['phone'] ?? '';
      default:
        return null;
    }
  }

  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  static String getFirstTwoCharsCapitalized(String? input) {
    if (input == null || input.isEmpty) {
      return "";
    }
    String firstTwoChars =
        input.substring(0, input.length >= 2 ? 2 : input.length);
    return firstTwoChars.toUpperCase();
  }

  static String getFirstCharCapitalized(String? input) {
    if (input == null || input.isEmpty) {
      return "";
    }
    String firstChar = input.substring(0, 1);
    return firstChar.toUpperCase();
  }
}
