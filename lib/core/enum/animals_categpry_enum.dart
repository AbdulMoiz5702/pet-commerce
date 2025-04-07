


enum AnimalsCategoryEnum {
  dogs,
  cats,
  birds,
  goats,
  chickens,
  cows,
  sheep,
  others,
}

enum GenderEnum {
  male,
  female,
}

abstract class PetMetadata {
  // Base class for metadata to be extended by specific pet types
  Map<String, dynamic> toJson();
}

