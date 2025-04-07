
import 'package:animals/Repository/user_profile_repo/user_profile_repo.dart';
import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:animals/models/user_model/user_profle_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getProfileProvider = StreamProvider.family<UserProfile, BuildContext>((ref, context) {
  final userId = AppConstants.supaBase.auth.currentUser!.id;
  return UserProfileRepo.getUserProfileData(userId: userId, context: context);
});
