


import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:animals/view/common/text_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/presentation/app_colors.dart';


class ListCardUiRow extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color iconColor;
  const ListCardUiRow({super.key, required this.title,required this.iconData,this.iconColor = AppColor.mediumGrey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData,color: iconColor,size: 15,),
        const Sized(width: 0.02,),
        lightText(title: title),
      ],
    );
  }
}
