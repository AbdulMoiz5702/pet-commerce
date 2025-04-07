import 'package:animals/view/common/text_widgets.dart';
import 'package:flutter/material.dart';
import '../../core/constants/presentation/app_colors.dart';
import '../../core/constants/presentation/font_manager.dart';
import 'custom_sizedBox.dart';





class CustomButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap;
  final double height ;
  final double width ;
  final Color color ;
  final double fontSize;
  final FontWeight fontWeight ;
  const CustomButton({super.key,required this.title,required this.onTap,this.height = 0.06,this.width = 1,this.color = AppColor.blackColor,this.fontSize = AppTextSize.medium, this.fontWeight = AppTextWeight.medium,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height *height ,
        width: MediaQuery.sizeOf(context).width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: mediumText(title: title,fontSize: fontSize.toDouble(),color: AppColor.whiteColor,fontWeight:fontWeight ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap;
  final double height ;
  final double width ;
  final Color color ;
  final double fontSize;
  final FontWeight fontWeight ;
  final IconData iconData;
  final double radius ;
  const CustomIconButton({super.key,required this.title,required this.onTap,this.height = 0.06,this.width = 1,this.color = AppColor.blackColor,this.fontSize = AppTextSize.medium, this.fontWeight = AppTextWeight.medium,required this.iconData,this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height *height ,
        width: MediaQuery.sizeOf(context).width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData,color: AppColor.whiteColor),
            const Sized(width: 0.02,),
            mediumText(title: title,fontSize: fontSize.toDouble(),color: AppColor.whiteColor,fontWeight:fontWeight ),
          ],
        ),
      ),
    );
  }
}

class TapIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final Color color ;
  final double size;
  const TapIcon({super.key,required this.iconData,this.color = AppColor.whiteColor,this.size = 20,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        iconData,
        color: color,
        size: size,
      ),
    );
  }
}

