import 'dart:async';
import 'package:animals/Repository/auth_repo/otp_repo.dart';
import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/exceptions/net_work_excptions.dart';



final otpProvider = StateNotifierProvider.autoDispose<VerifyNotifier,VerifyState>((ref){
  return VerifyNotifier(ref);
});

class VerifyNotifier extends StateNotifier<VerifyState> {
  final Ref ref;
  VerifyNotifier(this.ref) : super(VerifyState(isLoading: false, resendLoading: false, secondsRemaining: 0,forgotLoading: false));

  TextEditingController otpController = TextEditingController();
  Timer? _timer;





  Future<void> confirmOtp({
    required String email,
    required BuildContext context,
    required OtpType otpType,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      await OtpRepo.confirmOtp(email: email, otpController: otpController.text.trim(), otpType: otpType, context: context);
      state = state.copyWith(isLoading: false);
    } catch (error) {
      ExceptionHandler.handle(error, context);
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> resendOtp({required String email, required BuildContext context,required OtpType otpType}) async {
    if (state.secondsRemaining > 0) return;
    try {
      state = state.copyWith(resendLoading: true);
      await OtpRepo.resendOtp(email: email, otpType: otpType);
      otpController.clear();
      startTimer();
      state = state.copyWith(resendLoading: false);
    } catch (error) {
      ExceptionHandler.handle(error, context);
      state = state.copyWith(resendLoading: false);
    }
  }

  void startTimer() {
    state = state.copyWith(secondsRemaining: 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining > 0) {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> saveUserData({required BuildContext context}) async {
    try {
      await OtpRepo.saveUserData(context: context);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }


  @override
  void dispose() {
    otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}


class VerifyState {
  final bool isLoading;
  final bool resendLoading;
  final int secondsRemaining;
  final bool forgotLoading ;
  VerifyState({
    required this.isLoading,
    required this.resendLoading,
    required this.secondsRemaining,
    required this.forgotLoading,
  });

  VerifyState copyWith({bool? isLoading, bool? resendLoading, int? secondsRemaining,bool? forgotLoading}) {
    return VerifyState(
      isLoading: isLoading ?? this.isLoading,
      resendLoading: resendLoading ?? this.resendLoading,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      forgotLoading: forgotLoading ?? this.forgotLoading,
    );
  }
}


