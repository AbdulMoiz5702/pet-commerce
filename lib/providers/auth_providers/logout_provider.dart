import 'package:animals/Repository/auth_repo/logout_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:supabase/supabase.dart';
import '../../core/exceptions/net_work_excptions.dart';




final logoutProvider = StateNotifierProvider.autoDispose<LogoutNotifier,LogoutState>((ref){
  return LogoutNotifier();
});

class LogoutNotifier extends StateNotifier<LogoutState> {
  LogoutNotifier():super(LogoutState(isDeleteAccount:false ));

  Future<void> logoutLocal({required BuildContext context,required SignOutScope scope}) async{
    try{
      LogoutRepo.logoutUser(context: context,scope: scope);
    }catch(e){
      Navigator.pop(context);
      ExceptionHandler.handle(e, context);
    }
  }


  Future<void> deleteUserAccount({required BuildContext context}) async{
    try{
      state = state.copyWith(isDeleteAccount: true);
      LogoutRepo.deleteUserAccount(context: context);
     state = state.copyWith(isDeleteAccount: false);
    }catch(e){
      state = state.copyWith(isDeleteAccount: false);
      ExceptionHandler.handle(e, context);
    }
  }
}

class LogoutState {
  final bool isDeleteAccount;
  LogoutState({required this.isDeleteAccount});
  LogoutState  copyWith({bool ? isDeleteAccount}){
    return LogoutState(isDeleteAccount: isDeleteAccount ?? this.isDeleteAccount);
  }
}