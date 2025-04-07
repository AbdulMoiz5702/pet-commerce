import 'dart:io';
import 'package:flutter/material.dart';

import '../../core/constants/app_constant/app_constant.dart';
import '../../core/services/supbase_services/SupaStorageServices.dart';
import '../../core/services/supbase_services/supaBase_services.dart';
import '../../models/animal_models/animal_models.dart';
import '../../models/image_model/image_model.dart';

class AddListingRepo {

  static Future<String?> uploadVideo({required BuildContext context, required File video,}) async {
    return await StorageHelper.uploadFile(
      userId: AppConstants.currentUser!.id,
      category: AppConstants.userListingPictures,
      file: video,
      context: context,
    );
  }


  static Future<List<Media>> uploadImages({required BuildContext context, required List<File> images,}) async {
    List<Media> uploadedImages = [];
    List<Future<Media?>> uploadImageTasks = images.map((image) async {
      String? imageUrl = await StorageHelper.uploadFile(
        userId: AppConstants.currentUser!.id,
        category: AppConstants.userListingPictures,
        file: image,
        context: context,
      );
      return (imageUrl != null && imageUrl.isNotEmpty) ? Media(id: AppConstants.generateUuid(), url: imageUrl) : null;}).toList();
    List<Media?> results = await Future.wait(uploadImageTasks);
    uploadedImages.addAll(results.whereType<Media>());
    return uploadedImages;
  }


  static Future<void> insertDataToSupaBase({
    required BuildContext context,
    required AnimalModels highlights,
  }) async {
    await SupaBaseServices.insertData(
      tableName: AppConstants.animalsTable,
      data: highlights.toJson(),
      context: context,
    );
  }



}