import 'dart:async';
import 'package:animals/Repository/auth_repo/sign_up_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import '../../core/exceptions/net_work_excptions.dart';




final signupProvider = StateNotifierProvider.autoDispose<SignupNotifier,SignupState>((ref){
  return SignupNotifier();
});

class SignupNotifier extends StateNotifier<SignupState>{

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPassword.dispose();
    nameController.dispose();
  }
  SignupNotifier():super(SignupState(isLoading: false,password: '',));

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();


  updatePasswordStrength(){
    state = state.copyWith(password: passwordController.text);
  }





  Future<void> signupUser({required BuildContext context})async{
    try{
      state = state.copyWith(isLoading: true);
      await SignUpRepo.createUser(email: emailController.text.trim(), password: passwordController.text.trim(), name: nameController.text.trim(), context: context);
      state = state.copyWith(isLoading: false);
    }catch(error){
      state = state.copyWith(isLoading: false);
      ExceptionHandler.handle(error, context);
      rethrow;
    }
  }


}

class SignupState {
  final bool isLoading ;
  final String password ;
  SignupState({required this.isLoading,required this.password});

  SignupState copyWith({bool ? isLoading,String ? password}){
    return SignupState(isLoading: isLoading ?? this.isLoading,password: password ?? this.password);
  }
}


