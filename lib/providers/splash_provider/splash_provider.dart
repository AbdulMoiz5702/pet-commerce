import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:animals/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final splashProvider = Provider.autoDispose((ref){
  return SplashNotifier();
});

class SplashNotifier {
  Future<void> checkUserStatus({required BuildContext context})async{
    if(AppConstants.supaBase.auth.currentUser != null){
      print('userId : ${AppConstants.supaBase.auth.currentUser!.id}');
      Navigator.pushReplacementNamed(context, Routes.bottomNav);
    }else{
      Navigator.pushNamed(context, Routes.signup);
    }
  }
}