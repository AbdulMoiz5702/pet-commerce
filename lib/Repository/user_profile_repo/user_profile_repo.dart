import 'dart:io';
import 'package:animals/core/services/supbase_services/supaBase_services.dart';
import 'package:flutter/cupertino.dart';
import '../../core/constants/app_constant/app_constant.dart';
import '../../core/services/supbase_services/SupaStorageServices.dart';
import '../../models/user_model/user_profle_model.dart';

class UserProfileRepo {

  static  getUserProfileData({required String userId, required BuildContext context}) {
    return SupaBaseServices.getData(
      tableName: AppConstants.userProfileTable,
      column: 'user_id',
      value: userId,
      primaryKey: ['id'],
      context: context,
    ).map<UserProfile>((dataList) => UserProfile.fromJson(dataList.first));
  }

  static Future<String?> uploadUserProfileImage({required File file, required BuildContext context}) async {
    return await StorageHelper.uploadImage(
      file: file,
      bucketName: AppConstants.profilePicturesBucket,
      context: context,
      userId: AppConstants.supaBase.auth.currentUser!.id,
    );
  }


  static Future<void> updateUserPic({required String url,required BuildContext context}) async{
  await SupaBaseServices.updateData(tableName: AppConstants.userProfileTable, updatedData: {
     'image_url': url,
   }, column: 'user_id', value:AppConstants.supaBase.auth.currentUser!.id, context: context);
 }

 static Future<void> updateUserDetails({required String location, required String description,required String phone,required BuildContext context}) async {
   await SupaBaseServices.updateData(tableName: AppConstants.userProfileTable, updatedData: {
     'location':location,
     'Description':description,
     'phone':phone,
   }, column: 'user_id', value: AppConstants.supaBase.auth.currentUser!.id, context: context);
   Navigator.pop(context);
 }

 static Future<void> updateUserProfile({required BuildContext context,required String name }) async {
   await SupaBaseServices.updateData(tableName: AppConstants.userProfileTable, updatedData: {
     'name':name,
   }, column: 'user_id', value: AppConstants.supaBase.auth.currentUser!.id, context: context);
 }

}