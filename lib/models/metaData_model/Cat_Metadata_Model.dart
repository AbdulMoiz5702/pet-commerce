

import '../../core/enum/animals_categpry_enum.dart';

class CatMetadata extends PetMetadata {
  final String breed;
  final String color;
  final bool vaccinated;

  CatMetadata({
    required this.breed,
    required this.color,
    required this.vaccinated,
  });

  factory CatMetadata.fromJson(Map<String, dynamic> json) {
    return CatMetadata(
      breed: json['breed'],
      color: json['color'],
      vaccinated: json['vaccinated'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'color': color,
      'vaccinated': vaccinated,
    };
  }
}
