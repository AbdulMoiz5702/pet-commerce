import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enum/animals_categpry_enum.dart';

final filterProvider = StateNotifierProvider<FilterNotifier, FiltersState>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<FiltersState> {
  FilterNotifier() : super(FiltersState());

  void updateGender(GenderEnum? gender) {
    state = state.copyWith(gender: gender);
  }

  void updateCategory(AnimalsCategoryEnum? category) {
    state = state.copyWith(category: category);
  }

  void updateLocation(String? location) {
    state = state.copyWith(location: location);
  }

  void updatePriceRange(double min, double max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }

  void resetFilters() {
    state = FiltersState();
  }
}



class FiltersState {
  final GenderEnum? gender;
  final AnimalsCategoryEnum? category;
  final String? location;
  final double minPrice;
  final double maxPrice;

  FiltersState({
    this.gender,
    this.category,
    this.location,
    this.minPrice = 0.0,
    this.maxPrice = 0.0,
  });

  FiltersState copyWith({
    GenderEnum? gender,
    AnimalsCategoryEnum? category,
    String? location,
    double? minPrice,
    double? maxPrice,
  }) {
    return FiltersState(
      gender: gender ?? this.gender,
      category: category ?? this.category,
      location: location ?? this.location,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

}


