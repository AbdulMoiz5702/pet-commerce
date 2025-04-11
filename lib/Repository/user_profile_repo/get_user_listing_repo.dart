import 'package:flutter/material.dart';
import '../../core/constants/app_constant/app_constant.dart';
import '../../core/services/supbase_services/supaBase_services.dart';
import '../../models/animal_models/animal_models.dart';

class GetUserListingRepo {

  static getUserListing({required String userId, required BuildContext context}){
    return SupaBaseServices.getData(
      tableName: AppConstants.animalsTable,
      column: 'user_id',
      value: userId,
      primaryKey: ['id'],
      context: context,
    )..map((event) {
      return event.map((e) {
        return AnimalModels.fromJson(e);
      }).toList();
    });
  }

}