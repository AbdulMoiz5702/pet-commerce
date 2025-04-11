import 'dart:async';
import 'package:animals/Repository/auth_repo/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../core/exceptions/net_work_excptions.dart';



final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier,LoginState>((ref){
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<LoginState>{

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
  LoginNotifier():super(LoginState(isLoading: false,forgotLoading: false,otpLoading: false));


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser({required BuildContext context})async{
    try{
       state = state.copyWith(isLoading: true);
       await  LoginRepo.loginUser(context: context, email: emailController.text.trim(), password: passwordController.text.trim());
       state = state.copyWith(isLoading: false);
    }catch(error){
      state = state.copyWith(isLoading: false);
      ExceptionHandler.handle(error, context);
    }
  }

  Future<void> forgotPassword({ required BuildContext context}) async {
    try {
      state = state.copyWith(forgotLoading: true);
      await LoginRepo.forgotPassword(context: context, email: emailController.text.trim());
      state = state.copyWith(forgotLoading: false);
    }catch (error) {
      state = state.copyWith(forgotLoading: false);
      ExceptionHandler.handle(error, context);
    }
  }

  Future<void> loginWithOtp({ required BuildContext context}) async {
    try {
      state = state.copyWith(otpLoading: true);
      await LoginRepo.loginWithOtp(context: context, email: emailController.text.trim());
      state = state.copyWith(otpLoading: false);
    } catch (error) {
      state = state.copyWith(otpLoading: false);
      ExceptionHandler.handle(error, context);
    }
  }

}

class LoginState {
  final bool isLoading;
  final bool forgotLoading ;
  final bool otpLoading ;
  LoginState({
    required this.isLoading,
    required this.forgotLoading,
    required this.otpLoading,
  });

  LoginState copyWith({bool? isLoading,bool? forgotLoading,bool ? otpLoading}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      forgotLoading: forgotLoading ?? this.forgotLoading,
      otpLoading: otpLoading ?? this.otpLoading,
    );
  }
}




