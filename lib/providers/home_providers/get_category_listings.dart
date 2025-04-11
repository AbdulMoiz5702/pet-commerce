import 'package:animals/Repository/home_repo/get_category_listings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enum/animals_categpry_enum.dart';
import '../../models/animal_models/animal_models.dart';

final getCategoryListings = StreamProvider.family
    .autoDispose<List<AnimalModels>, AnimalsCategoryEnum>((ref, category) {
  return CategoryListingRepo.getCategoryListing(
    category: category,
  );
});
