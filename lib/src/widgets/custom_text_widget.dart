import 'package:flutter/material.dart';
import 'package:mca_official_flutter_sdk/src/constants/custom_colors.dart';
import 'package:mca_official_flutter_sdk/src/utils/custom_text_styles.dart';

Widget semiBoldText(
  String title, {
  Key? key,
  double? fontSize = 13,
  Color? color = CustomColors.blackTextColor,
  TextAlign? textAlign,
  int? maxLines,
}) =>
    Text(
      title,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      style: CustomTextStyles.semiBold(
        fontSize: fontSize,
        color: color,
      ),
    );

Widget regularText(
  String title, {
  Key? key,
  double? fontSize = 13,
  Color? color = CustomColors.blackTextColor,
  TextAlign? textAlign,
  int? maxLines,
}) =>
    Text(
      title,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      style: CustomTextStyles.regular(
        fontSize: fontSize,
        color: color,
      ),
    );

Widget w500Text(
  String title, {
  Key? key,
  double? fontSize = 13,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
}) =>
    Text(
      title,
      key: key,
      textAlign: textAlign,
      maxLines: maxLines,
      style: CustomTextStyles.w500(
        fontSize: fontSize,
        color: color,
      ),
    );
