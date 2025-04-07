import '../../core/enum/animals_categpry_enum.dart';

class DogMetadata extends PetMetadata {
  final String breed;
  final String size;
  final bool vaccinated;

  DogMetadata({
    required this.breed,
    required this.size,
    required this.vaccinated,
  });

  factory DogMetadata.fromJson(Map<String, dynamic> json) {
    return DogMetadata(
      breed: json['breed'],
      size: json['size'],
      vaccinated: json['vaccinated'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'size': size,
      'vaccinated': vaccinated,
    };
  }
}
