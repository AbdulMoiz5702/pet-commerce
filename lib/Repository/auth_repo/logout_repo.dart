import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:animals/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class LogoutRepo {


  static Future<void> logoutUser({required BuildContext context,required SignOutScope scope}) async{
    await AppConstants.supaBase.auth.signOut(scope: scope).then((v){
      Navigator.pushNamedAndRemoveUntil(context,Routes.login, (route)=> false);
    });
  }

  static Future<void> deleteUserAccount({required BuildContext context}) async {
    await AppConstants.supaBase.auth.admin.deleteUser(AppConstants.supaBase.auth.currentUser!.id).then((value){
      Navigator.pushNamedAndRemoveUntil(context, Routes.signup, (route)=> false);
    });
  }
}