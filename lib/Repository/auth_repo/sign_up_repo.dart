import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../../core/routes/routes.dart';



class SignUpRepo {

  static  Future<void> createUser({required String email,required String password,required String name,required BuildContext context }) async {
    await AppConstants.supaBase.auth.signUp(
      email: email,
      password: password,
    ).then((value) {
      userName = name;
      userEmail = email;
      userId = value.user!.id ;
      Navigator.pushNamed(context, Routes.verifyOtp,
        arguments: {
          'email': email,
          'otpType': OtpType.signup,
        },
      );
    }).timeout(const Duration(seconds: 5));
  }




}