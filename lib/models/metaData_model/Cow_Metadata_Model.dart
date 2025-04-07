

import '../../core/enum/animals_categpry_enum.dart';

class CowMetadata extends PetMetadata {

  final String breed;
  final String milkProduction;
  final bool pregnant;

  CowMetadata({
    required this.breed,
    required this.milkProduction,
    required this.pregnant,
  });

  factory CowMetadata.fromJson(Map<String, dynamic> json) {
    return CowMetadata(
      breed: json['breed'],
      milkProduction: json['milkProduction'],
      pregnant: json['pregnant'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'milkProduction': milkProduction,
      'pregnant': pregnant,
    };
  }
}
