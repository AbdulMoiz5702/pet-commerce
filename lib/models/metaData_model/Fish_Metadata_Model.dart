



import '../../core/enum/animals_categpry_enum.dart';

class FishMetadata extends PetMetadata {
  final String waterType;
  final String tankSize;

  FishMetadata({
    required this.waterType,
    required this.tankSize,
  });

  factory FishMetadata.fromJson(Map<String, dynamic> json) {
    return FishMetadata(
      waterType: json['waterType'],
      tankSize: json['tankSize'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'waterType': waterType,
      'tankSize': tankSize,
    };
  }
}
