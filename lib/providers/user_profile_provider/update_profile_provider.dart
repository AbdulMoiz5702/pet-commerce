import 'dart:io';
import 'package:animals/Repository/user_profile_repo/user_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/helper_fuctions/helper_function.dart';
import '../../core/utils/helper_fuctions/snack_bar.dart';

final userProfileUpdate = StateNotifierProvider.autoDispose<ProfileUpdateNotifier,ProfileUpdateState>((ref){
  return ProfileUpdateNotifier();
});




class ProfileUpdateNotifier extends StateNotifier<ProfileUpdateState> {
  ProfileUpdateNotifier(): super(ProfileUpdateState(isLoading: false,isSecondLoading: false,checkUserName: false,imageUrl: '',image: null));

  @override
  void dispose() {
    location.dispose();
    description.dispose();
    phone.dispose();
    name.dispose();
    super.dispose();
  }

  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();


  Future<void> pickAndUploadProfileImage(BuildContext context) async {
    try {
      File? pickedImage  = await HelperFunctions.pickImage(context: context);
      state = state.copyWith(image: pickedImage);
      if ( state.image == null){
        SnackBarClass.errorSnackBar(context: context, message: 'Error please upload picture again');
      }else{
        String? uploadedUrl = await UserProfileRepo.uploadUserProfileImage(file: state.image!, context: context);
        print('uploadedUrl : $uploadedUrl');
        if (uploadedUrl != null) {
          state = state.copyWith(imageUrl: uploadedUrl);
          await UserProfileRepo.updateUserPic(url: state.imageUrl, context: context);
        }
      }
    } catch (error) {
      rethrow;
    }
  }


  Future<void> updateUserDetails({required BuildContext context}) async{
    try{
      state = state.copyWith(isSecondLoading: true);
       await UserProfileRepo.updateUserDetails(location: location.text.toString(), description: description.text.toString(), phone: phone.text.toString(), context: context).then((value){
        location.clear();
        description.clear();
        phone.clear();
      });
      state = state.copyWith(isSecondLoading: false);
    }catch(error){
      state = state.copyWith(isSecondLoading: false);
    }
  }

  Future<void> updateUserProfile({required BuildContext context}) async{
    try{
      state = state.copyWith(isLoading: true);
       await UserProfileRepo.updateUserProfile(name: name.text.toString(),context: context).then((v){
        Navigator.pop(context);
        name.clear();
      });
      state = state.copyWith(isLoading: false);
    } catch(error){
      state = state.copyWith(isLoading: false);
    }
  }



}


class ProfileUpdateState {
  final bool isLoading;
  final bool isSecondLoading ;
  final bool checkUserName ;
  final String imageUrl;
  File  ? image ;
  ProfileUpdateState({required this.isLoading,required this.isSecondLoading,required this.checkUserName,required this.imageUrl,required this.image});
  ProfileUpdateState copyWith({bool ?isLoading, bool ? isSecondLoading,bool ? checkUserName,String ? imageUrl,File ? image}){
    return ProfileUpdateState(isLoading: isLoading?? this.isLoading, isSecondLoading: isSecondLoading ?? this.isSecondLoading,checkUserName: checkUserName ?? this.checkUserName,imageUrl: imageUrl ?? this.imageUrl,image: image ?? this.image);
  }
}