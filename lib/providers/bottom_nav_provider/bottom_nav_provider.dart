import 'package:animals/Repository/user_profile_repo/get_user_name_repo.dart';
import 'package:animals/core/exceptions/net_work_excptions.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';


 final bottomNavProvider = StateNotifierProvider<BottomNavNotifier,BottomNavState>((ref){
   return BottomNavNotifier();
 });



class BottomNavNotifier extends StateNotifier<BottomNavState>{
  BottomNavNotifier():super(BottomNavState(currentIndex: 0));
  void changeIndex({required int index}){
    state = state.copyWith(currentIndex: index);
  }

  Future<void> getUserName({required BuildContext context})async{
    try{
      await GetUserName.getUserName();
    }catch(e){
      ExceptionHandler.handle(e, context);
    }
  }
}






class BottomNavState {
  final int currentIndex;
  BottomNavState({required this.currentIndex});
  BottomNavState copyWith ({int ? currentIndex}){
    return BottomNavState(currentIndex: currentIndex ?? this.currentIndex);
  }
}