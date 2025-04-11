import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:animals/core/exceptions/net_work_excptions.dart';
import '../../core/enum/animals_categpry_enum.dart';
import '../../models/animal_models/animal_models.dart';

class CategoryListingRepo {
  static getCategoryListing({
    required AnimalsCategoryEnum category,
  }) {
    try {
      return AppConstants.supaBase
          .from(AppConstants.animalsTable)
          .stream(primaryKey: ['id'])
          .eq('category', category.toString().split('.').last)
          .map((event) {
            return event.map((e) {
              return AnimalModels.fromJson(e);
            }).toList();
          });
    } catch (e) {
      throw ExceptionHandler.getMessage(e);
    }
  }
}
