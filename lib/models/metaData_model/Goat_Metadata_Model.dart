import '../../core/enum/animals_categpry_enum.dart';

class GoatMetadata extends PetMetadata {
  final String breed;
  final bool pregnant;

  GoatMetadata({
    required this.breed,
    required this.pregnant,
  });

  factory GoatMetadata.fromJson(Map<String, dynamic> json) {
    return GoatMetadata(
      breed: json['breed'],
      pregnant: json['pregnant'],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'pregnant': pregnant,
    };
  }
}
