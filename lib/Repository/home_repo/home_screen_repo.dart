import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:flutter/material.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../models/animal_models/animal_models.dart';

class HomeScreenListing {

  static Stream<List<AnimalModels>> getAllListing({required BuildContext context,}) {
    try {
      return AppConstants.supaBase.from(AppConstants.animalsTable).stream(primaryKey: ['id']).map((event) => event.map((e) => AnimalModels.fromJson(e)).toList());
    } catch (e) {
      ExceptionHandler.handle(e, context);
      rethrow;
    }
  }
}
