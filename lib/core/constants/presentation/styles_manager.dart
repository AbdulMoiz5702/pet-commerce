import 'package:flutter/material.dart';
import 'font_manager.dart';


TextStyle _getTextStyle({
  required double fontSize,
  required String fontFamily,
  required Color color,
  required FontWeight fontWeight,
  double letterSpacing = 0.2,
  double? height,
  TextDecoration decoration = TextDecoration.none,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    fontFamily: fontFamily,
    fontSize: fontSize,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
    decoration: decoration,
  );
}

// Regular
TextStyle getRegularTextStyle({
  double fontSize = AppTextSize.regular,
  String fontFamily = FontConstants.fontFamily,
  required Color color,
  FontWeight fontWeight = AppTextWeight.regular,
  double? height,
  double letterSpacing = 0.2,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

// Light
TextStyle getLightTextStyle({
  double fontSize = AppTextSize.light,
  String fontFamily = FontConstants.fontFamily,
  required Color color,
  FontWeight fontWeight = AppTextWeight.light,
  double? height,
  double letterSpacing = 0.2,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

// Medium
TextStyle getMediumTextStyle({
  double fontSize = AppTextSize.medium,
  String fontFamily = FontConstants.fontFamily,
  required Color color,
  FontWeight fontWeight = AppTextWeight.medium,
  double? height,
  double letterSpacing = 0.2,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

// Semi Bold
TextStyle getSemiBoldTextStyle({
  double fontSize = AppTextSize.semiBold,
  String fontFamily = FontConstants.fontFamily,
  required Color color,
  FontWeight fontWeight = AppTextWeight.semiBold,
  double? height,
  double letterSpacing = 0.2,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

// Bold
TextStyle getBoldTextStyle({
  double fontSize = AppTextSize.bold,
  String fontFamily = FontConstants.fontFamily,
  required Color color,
  FontWeight fontWeight = AppTextWeight.bold,
  double? height,
  double letterSpacing = 0.2,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}
