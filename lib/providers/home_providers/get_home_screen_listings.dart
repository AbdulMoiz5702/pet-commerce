import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Repository/home_repo/home_screen_repo.dart';
import '../../models/animal_models/animal_models.dart';

final allAnimalListingProvider = StreamProvider.autoDispose.family<List<AnimalModels>, BuildContext>((ref, context) {
  return HomeScreenListing.getAllListing(context: context);
});

