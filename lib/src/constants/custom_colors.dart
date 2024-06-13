import 'package:flutter/material.dart';
import 'package:mca_official_flutter_sdk/src/globals.dart';

class CustomColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const backBorderColor = Color(0xFFF9FAFB);
  static const lightGreenColor = Color(0xFFE6F4F2);
  static const blackTextColor = Color(0xFF101828);
  static const greyTextColor = Color(0xFF667085);
  static const redExitColor = Color(0xFFF04438);

  static const greyToastColor = Color(0xFF9CA3AF);
  static const dividerGreyColor = Color(0xFFEAECF0);
  static const checkBoxBorderColor = Color(0xFF98A2B3);
  static const productBorderColor = Color(0xFFD0D5DD);
  static const discountBgColor = Color(0xFFF2F4F7);
  static const backTextColor = Color(0xFF344054);

  static const darkTextColor = Color(0xFF070707);

  static const formTitleColor = Color(0xFF475467);
  static const formHintColor = Color(0xFF999CA0);

  static const lightBlackColor = Color(0xFF747474);
  static const orangeColor = Color(0xFFF79009);
  static const lightOrangeColor = Color(0xFFFFFAEB);

  static Color primaryBrandColor() {
    String? brandColorPrimary = Global.brandColorPrimary;
    bool isDefaultColour = (Global.businessDetails == null ||
        Global.businessDetails?.isDefaultLogo == true);

    // Global.isDefaultColour;

    if (brandColorPrimary == null ||
        brandColorPrimary.isEmpty ||
        isDefaultColour == true) {
      return const Color(0xFF3BAA90);
    }

    brandColorPrimary = brandColorPrimary.toUpperCase().replaceAll("#", "");
    if (brandColorPrimary.length == 6) {
      brandColorPrimary = "FF$brandColorPrimary";
    }

    if (brandColorPrimary.length != 8) {
      return const Color(0xFF3BAA90);
    }

    try {
      return Color(int.parse(brandColorPrimary, radix: 16));
    } catch (e) {
      return const Color(0xFF3BAA90);
    }
  }

  static Color lightPrimaryBrandColor() =>
      primaryBrandColor().withOpacity(0.07);
}
