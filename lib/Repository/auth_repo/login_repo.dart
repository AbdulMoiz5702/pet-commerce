


import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:animals/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class LoginRepo {

  static Future<void> loginUser({required BuildContext context,required String email,required String password}) async {
    await AppConstants.supaBase.auth.signInWithPassword(
      email: email,
      password: password,
    ).then((value){
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Routes.bottomNav);
    }).timeout(const Duration(seconds: 10));
  }

  static Future<void> forgotPassword({required BuildContext context,required String email,})async{
    await AppConstants.supaBase.auth.resetPasswordForEmail(
      email,
    ).timeout(const Duration(seconds: 10));
    Navigator.pushReplacementNamed(context, Routes.verifyOtp,
      arguments: {
        'email': email,
        'otpType': OtpType.recovery,
      },
    );
  }

  static Future<void> loginWithOtp({required BuildContext context,required String email}) async {
    await AppConstants.supaBase.auth.signInWithOtp(
      email: email,
      shouldCreateUser: false,
    ).timeout(const Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, Routes.verifyOtp,
      arguments: {
        'email': email,
        'otpType': OtpType.magiclink,
      },
    );
  }

}