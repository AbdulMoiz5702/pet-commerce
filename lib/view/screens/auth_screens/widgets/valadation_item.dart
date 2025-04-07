
import 'package:animals/view/common/text_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/presentation/app_colors.dart';
import '../../../common/custom_sizedBox.dart';


Widget buildValidationItem(String text, bool isValid) {
  return Row(
    children: [
      Icon(isValid ? Icons.check_circle : Icons.cancel, color: isValid ? AppColor.successColor :  AppColor.errorColor,size: 12,),
      const Sized(width: 0.03,),
      lightText(title: text,color: isValid ? AppColor.successColor :  AppColor.errorColor)
    ],
  );
}