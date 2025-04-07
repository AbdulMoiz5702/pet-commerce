import 'package:animals/core/constants/presentation/styles_manager.dart';
import 'package:flutter/material.dart';
import '../../core/constants/presentation/app_colors.dart';
import '../../core/constants/presentation/font_manager.dart';



Widget regularText({
  required String title,
  Color color = AppColor.blackColor,
  double fontSize = AppTextSize.regular,
  FontWeight fontWeight = AppTextWeight.regular,
  double? height,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    title,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: getRegularTextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    ),
  );
}

Widget lightText({
  required String title,
  Color color = AppColor.blackColor,
  double fontSize = AppTextSize.light,
  FontWeight fontWeight = AppTextWeight.light,
  double? height,
  TextAlign textAlign = TextAlign.start,
  int maxLines = 10,
  TextOverflow overflow = TextOverflow.ellipsis,
}) {
  return Text(
    title,
    textAlign: textAlign,
    softWrap: true,
    maxLines: maxLines,
    overflow: overflow,
    style: getLightTextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    ),
  );
}

Widget mediumText({
  required String title,
  Color color = AppColor.blackColor,
  double fontSize = AppTextSize.medium,
  FontWeight fontWeight = AppTextWeight.medium,
  double? height,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    title,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: getMediumTextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    ),
  );
}

Widget semiBoldText({
  required String title,
  Color color = AppColor.blackColor,
  double fontSize = AppTextSize.semiBold,
  FontWeight fontWeight = AppTextWeight.semiBold,
  double? height,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    title,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: getSemiBoldTextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    ),
  );
}

Widget boldText({
  required String title,
  Color color = AppColor.blackColor,
  double fontSize = AppTextSize.bold,
  FontWeight fontWeight = AppTextWeight.bold,
  double? height,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return Text(
    title,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: getBoldTextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    ),
  );
}



