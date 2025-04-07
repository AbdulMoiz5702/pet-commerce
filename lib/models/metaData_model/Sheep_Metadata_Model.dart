



import '../../core/enum/animals_categpry_enum.dart';

class SheepMetadata extends PetMetadata {
  final String breed;
  final bool woolProduction;

  SheepMetadata({
    required this.breed,
    required this.woolProduction,
  });

  factory SheepMetadata.fromJson(Map<String, dynamic> json) {
    return SheepMetadata(
      breed: json['breed'],
      woolProduction: json['woolProduction'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'woolProduction': woolProduction,
    };
  }
}
