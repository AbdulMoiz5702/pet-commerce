


import '../../core/enum/animals_categpry_enum.dart';

class BirdMetadata extends PetMetadata {
  final String species;
  final String color;
  final String wingspan;

  BirdMetadata({
    required this.species,
    required this.color,
    required this.wingspan,
  });

  factory BirdMetadata.fromJson(Map<String, dynamic> json) {
    return BirdMetadata(
      species: json['species'],
      color: json['color'],
      wingspan: json['wingspan'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'species': species,
      'color': color,
      'wingspan': wingspan,
    };
  }
}
