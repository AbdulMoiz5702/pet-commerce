import 'package:flutter/material.dart';
import '../../core/constants/presentation/app_colors.dart';


class CustomLoading extends StatelessWidget {
  final Color color;
  const CustomLoading({super.key,this.color = AppColor.blackColor});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: color,),
    );
  }
}





