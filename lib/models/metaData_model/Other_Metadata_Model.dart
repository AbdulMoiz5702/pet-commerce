


import '../../core/enum/animals_categpry_enum.dart';

class OtherMetadata extends PetMetadata {
  final String description;

  OtherMetadata({
    required this.description,
  });

  factory OtherMetadata.fromJson(Map<String, dynamic> json) {
    return OtherMetadata(
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'description': description,
    };
  }
}
