

import 'package:flutter/material.dart';

import '../../core/enum/animals_categpry_enum.dart';
import '../metaData_model/Bird_Metadata_Model.dart';
import '../metaData_model/Cat_Metadata_Model.dart';
import '../metaData_model/Chicken_Metadata_Model.dart';
import '../metaData_model/Cow_Metadata_Model.dart';
import '../metaData_model/Dog_Metadata_Model.dart';
import '../metaData_model/Goat_Metadata_Model.dart';
import '../metaData_model/Other_Metadata_Model.dart';
import '../metaData_model/Sheep_Metadata_Model.dart';

class MetadataManager {
  final TextEditingController breedController;
  final TextEditingController sizeController;
  final TextEditingController colorController;
  final TextEditingController speciesController;
  final TextEditingController wingspanController;
  final TextEditingController milkProductionController;
  final TextEditingController tankSizeController;
  final TextEditingController waterTypeController;
  final TextEditingController otherDescriptionController;

  bool isVaccinated;
  bool isPregnant;
  bool laysEggs;
  bool woolProduction;

  MetadataManager({
    required this.breedController,
    required this.sizeController,
    required this.colorController,
    required this.speciesController,
    required this.wingspanController,
    required this.milkProductionController,
    required this.tankSizeController,
    required this.waterTypeController,
    required this.otherDescriptionController,
    required this.isVaccinated,
    required this.isPregnant,
    required this.laysEggs,
    required this.woolProduction,
  });

  PetMetadata getMetadata(AnimalsCategoryEnum category) {
    switch (category) {
      case AnimalsCategoryEnum.dogs:
        return DogMetadata(
          breed: breedController.text,
          size: sizeController.text,
          vaccinated: isVaccinated,
        );
      case AnimalsCategoryEnum.cats:
        return CatMetadata(
          breed: breedController.text,
          color: colorController.text,
          vaccinated: isVaccinated,
        );
      case AnimalsCategoryEnum.birds:
        return BirdMetadata(
          species: speciesController.text,
          color: colorController.text,
          wingspan: wingspanController.text,
        );
      case AnimalsCategoryEnum.goats:
        return GoatMetadata(
          breed: breedController.text,
          pregnant: isPregnant,
        );
      case AnimalsCategoryEnum.chickens:
        return ChickenMetadata(
          breed: breedController.text,
          layingEggs: laysEggs,
          color: colorController.text,
        );
      case AnimalsCategoryEnum.cows:
        return CowMetadata(
          breed: breedController.text,
          milkProduction: milkProductionController.text,
          pregnant: isPregnant,
        );
      case AnimalsCategoryEnum.sheep:
        return SheepMetadata(
          breed: breedController.text,
          woolProduction: woolProduction,
        );
      case AnimalsCategoryEnum.others:
        return OtherMetadata(
          description: otherDescriptionController.text,
        );
      default:
        return DogMetadata(breed: '', size: '', vaccinated: false);
    }
  }
}
