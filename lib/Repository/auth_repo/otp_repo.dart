// ignore_for_file: use_build_context_synchronously
import 'package:animals/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../../core/constants/app_constant/app_constant.dart';
import '../../core/services/supbase_services/supaBase_services.dart';
import '../../models/user_model/user_profle_model.dart';

class OtpRepo {


  static Future<void> confirmOtp({required String email,required String otpController,required OtpType otpType,required BuildContext context}) async {
    await AppConstants.supaBase.auth.verifyOTP(
      email: email,
      token: otpController,
      type: otpType,
    ).timeout(const Duration(seconds: 5));
    switch (otpType) {
      case OtpType.signup:
        saveUserData(context: context).then((value){
          Navigator.pushReplacementNamed(context, Routes.bottomNav);
        });
        break;
      case OtpType.magiclink:
        Navigator.pushReplacementNamed(context, Routes.bottomNav);
        break;
      case OtpType.recovery:
        Navigator.pushReplacementNamed(context, Routes.forgotPassword);
        break;
      default:
        Navigator.pushReplacementNamed(context, Routes.bottomNav);
    }
  }

  static Future<void> saveUserData({required BuildContext context}) async {
    var userData = UserProfile(
        userId: userId,
        name: userName,
        email: userEmail);
    await SupaBaseServices.insertData<Map<String, dynamic>>(tableName: AppConstants.userProfileTable, data: userData.toJson(),
        context: context
    );
  }

  static Future<void> resendOtp({required String email,required OtpType otpType}) async {
    await AppConstants.supaBase.auth.resend(
      email: email,
      type: otpType,
    ).timeout(const Duration(seconds: 10));
  }

  static String getTitle(OtpType otp) {
    switch (otp) {
      case OtpType.signup:
        return 'Signup';
      case OtpType.magiclink:
        return 'Login';
      case OtpType.recovery:
        return 'Confirm Password';
      default:
        return 'Confirm';
    }
  }

}