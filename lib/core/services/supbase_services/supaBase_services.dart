
// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:flutter/cupertino.dart';

import '../../exceptions/net_work_excptions.dart';




class SupaBaseServices {


  static  getData({required String tableName, required String column, required dynamic value, required List<String> primaryKey, required BuildContext context,}) {
    try{
      return AppConstants.supaBase.from(tableName).stream(primaryKey: primaryKey).eq(column, value);
    }catch(e){
      ExceptionHandler.handle(e,context);
    }
  }





  static Future<void> insertData<T extends Map<String, dynamic>>({required String tableName, required T data,required BuildContext context}) async {
    try {
      await AppConstants.supaBase.from(tableName).insert(data).select().timeout(const Duration(seconds: 10));
    } catch (e) {
       ExceptionHandler.handle(e,context);
    }
  }



  static Future<void> updateData<T>({required String tableName,required Map<String, dynamic> updatedData,required String column,required dynamic value,required BuildContext context}) async {
    try {
      await AppConstants.supaBase.from(tableName).update(updatedData).eq(column, value).select().timeout(const Duration(seconds: 10));
    } catch (e) {
       ExceptionHandler.handle(e,context);
    }
  }



  static Future<void> deleteData({required String tableName,required String column,required dynamic value,required BuildContext context}) async {
    try {
      await AppConstants.supaBase.from(tableName).delete().eq(column, value).select().timeout(const Duration(seconds: 10));
    } catch (e) {
       ExceptionHandler.handle(e,context);
    }
  }



}