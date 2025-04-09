import 'package:animals/core/constants/presentation/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/other_conts/list_const.dart';
import '../../../core/constants/presentation/app_colors.dart';
import '../../../providers/bottom_nav_provider/bottom_nav_provider.dart';





class BottomNavScreen extends ConsumerWidget {
  final bool isRequestChangeEmail ;
  const BottomNavScreen({super.key,this.isRequestChangeEmail = false});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.read(bottomNavProvider.notifier).getUserName(context: context);
    return Scaffold(
      body: Consumer(builder: (context,ref,_){
        var data = ref.watch(bottomNavProvider.select((state)=> state.currentIndex));
        return screens[isRequestChangeEmail == true ? 3 : data];
      }),
      bottomNavigationBar: Consumer(builder: (context,ref,_){
        var data = ref.watch(bottomNavProvider.select((state)=> state.currentIndex));
        return BottomNavigationBar(
          currentIndex: isRequestChangeEmail == true ? 3 : data,
          items: items,
          onTap: (index) {
            ref.read(bottomNavProvider.notifier).changeIndex(index: index);
          },
          selectedItemColor: AppColor.successColor,
          unselectedItemColor: AppColor.disableColor,
          backgroundColor: AppColor.whiteColor,
          selectedLabelStyle: getMediumTextStyle(color: AppColor.successColor,),
          unselectedLabelStyle: getLightTextStyle(color: AppColor.disableColor,),
          iconSize: 24, // Set icon size
        );
      }),
    );
  }
}
