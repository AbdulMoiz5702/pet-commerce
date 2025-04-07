


import '../../core/enum/animals_categpry_enum.dart';

class ChickenMetadata extends PetMetadata {
  final String breed;
  final bool layingEggs;
  final String color;

  ChickenMetadata({
    required this.breed,
    required this.layingEggs,
    required this.color,
  });

  factory ChickenMetadata.fromJson(Map<String, dynamic> json) {
    return ChickenMetadata(
      breed: json['breed'],
      layingEggs: json['layingEggs'],
      color: json['color'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'layingEggs': layingEggs,
      'color': color,
    };
  }
}
