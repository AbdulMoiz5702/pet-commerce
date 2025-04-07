import 'dart:io';
import 'package:animals/core/utils/helper_fuctions/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../exceptions/net_work_excptions.dart';
import '../dialogs/helper_dialogs.dart';


class HelperFunctions {

  static final ImagePicker _picker = ImagePicker();
  static Future<File?> pickImage({ImageSource source = ImageSource.gallery,required BuildContext context}) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      ExceptionHandler.handle(e, context);
      return null;
    }
  }


  static Future<bool> requestPermission({
    required Permission permission,
    required BuildContext context,
  }) async {
    try {
      PermissionStatus status = await permission.request();
      if (status.isGranted) {
        return true; // ✅ Permission granted
      } else if (status.isDenied) {
        debugPrint("⚠️ Permission denied. Retrying...");
        return await _retryPermission(permission, context);
      } else if (status.isPermanentlyDenied) {
        debugPrint("⚠️ Permission permanently denied. Showing settings dialog...");
        DialogHelper.showSettingsDialog(context);
        return false;
      }
      return false;
    } catch (e) {
      ExceptionHandler.handle(e, context);
      return false;
    }
  }

  static Future<bool> _retryPermission(Permission permission, BuildContext context) async {
    for (int i = 0; i < 2; i++) {
      final status = await permission.request();
      if (status.isGranted) return true;
      if (status.isPermanentlyDenied) {
        DialogHelper.showSettingsDialog(context);
        return false;
      }
    }
    return false;
  }



  static Future<List<File>> pickMultipleImages({required BuildContext context}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isEmpty) return [];
      if (pickedFiles.length > 4) {
        SnackBarClass.errorSnackBar(
          context: context,
          message: 'You can select a maximum of 4 images.',
        );
        return [];
      }
      List<File> images = pickedFiles.map((xFile) => File(xFile.path)).toList();
      return images;
    } catch (error) {
      ExceptionHandler.handle(error, context);
      return [];
    }
  }

  static Future<File?> pickShortVideo({
    required BuildContext context,
    Duration maxDuration = const Duration(seconds: 10),
   }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile == null) return null;
      final File videoFile = File(pickedFile.path);
      final VideoPlayerController controller = VideoPlayerController.file(videoFile);
      await controller.initialize();
      final Duration videoDuration = controller.value.duration;
      await controller.dispose();
      if (videoDuration <= maxDuration) {
        return videoFile;
      } else {
        SnackBarClass.errorSnackBar(
          context: context,
          message: 'Please select a video of 10 seconds or less.',
        );
        return null;
      }
    } catch (error) {
      ExceptionHandler.handle(error, context);
      return null;
    }
  }


}
