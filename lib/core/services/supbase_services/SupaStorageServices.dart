import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:supabase/supabase.dart';

import '../../constants/app_constant/app_constant.dart';
import '../../exceptions/net_work_excptions.dart';

class StorageHelper {

  static Future<String?> uploadImage({
    required File file,
    required String bucketName,
    required String userId,
    required BuildContext context,
  }) async {
    try {
      String fileExtension = file.path.split('.').last;
      String fileName = 'profile_$userId.$fileExtension';
      await AppConstants.supaBase.storage.from(bucketName).upload(
        fileName,
        file,
        fileOptions: const FileOptions(upsert: true),
      );
      String imageUrl = AppConstants.supaBase.storage.from(bucketName).getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      ExceptionHandler.handle(e, context);
      return null;
    }
  }

 static Future<String?> uploadFile({
    required String userId,
    required String category,
    required File file,
    required BuildContext context,
  }) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      final filePath = '$userId/$category/$fileName';
      await AppConstants.supaBase.storage.from(AppConstants.userListingFiles).upload(filePath, file);
      final publicUrl = AppConstants.supaBase.storage.from(AppConstants.userListingFiles).getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      print("Upload error: $e");
      ExceptionHandler.handle(e, context);
      return null;
    }
  }


}
