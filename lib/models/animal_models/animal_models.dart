import 'package:animals/core/enum/animals_categpry_enum.dart';
import '../image_model/image_model.dart';
import '../metaData_model/Bird_Metadata_Model.dart';
import '../metaData_model/Cat_Metadata_Model.dart';
import '../metaData_model/Chicken_Metadata_Model.dart';
import '../metaData_model/Cow_Metadata_Model.dart';
import '../metaData_model/Dog_Metadata_Model.dart';
import '../metaData_model/Goat_Metadata_Model.dart';
import '../metaData_model/Other_Metadata_Model.dart';
import '../metaData_model/Sheep_Metadata_Model.dart';

class AnimalModels {
  final GenderEnum gender;
  final String age;
  final String sellerId;
  final AnimalsCategoryEnum category;
  final String name;
  final PetMetadata metadata;
  final List<Media> images;
  final String location;
  final List<String> impressions;
  final String phone;
  final String whatsapp;
  final String description;
  final String videoUrl;

  AnimalModels({
    required this.age,
    required this.gender,
    required this.sellerId,
    required this.category,
    required this.name,
    required this.metadata,
    required this.images,
    required this.location,
    required this.impressions,
    required this.phone,
    required this.whatsapp,
    required this.description,
    required this.videoUrl,
  });

  factory AnimalModels.fromJson(Map<String, dynamic> json) {
    // Handle metadata based on category
    PetMetadata metadata;
    switch (json['category']) {
      case 'dogs':
        metadata = DogMetadata.fromJson(json['metadata']);
        break;
      case 'cats':
        metadata = CatMetadata.fromJson(json['metadata']);
        break;
      case 'birds':
        metadata = BirdMetadata.fromJson(json['metadata']);
        break;
      case 'goats':
        metadata = GoatMetadata.fromJson(json['metadata']);
        break;
      case 'chickens':
        metadata = ChickenMetadata.fromJson(json['metadata']);
        break;
      case 'cows':
        metadata = CowMetadata.fromJson(json['metadata']);
        break;
      case 'sheep':
        metadata = SheepMetadata.fromJson(json['metadata']);
        break;
      case 'others':
        metadata = OtherMetadata.fromJson(json['metadata']);
        break;
      default:
        metadata = DogMetadata.fromJson(json['metadata']); // Default case
    }

    // Parse images
    List<Media> images = (json['images'] as List)
        .map((imageJson) => Media.fromJson(imageJson))
        .toList();

    return AnimalModels(
      sellerId: json['seller_id'],
      category: AnimalsCategoryEnum.values.firstWhere((e) => e.toString() == 'PetType.${json['category']}'),
      name: json['name'],
      metadata: metadata,
      images: images,
      location: json['location'],
      impressions: List<String>.from(json['impressions']),
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      gender: json['Gender'],
      age: json['Age'],
      description: json['Description'],
      videoUrl:  json['video_url']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seller_id': sellerId,
      'category': category.toString().split('.').last,
      'name': name,
      'metadata': metadata.toJson(),
      'images': images.map((image) => image.toJson()).toList(),
      'location': location,
      'impressions': impressions,
      'phone': phone,
      'whatsapp': whatsapp,
      'Gender':gender,
      'Age':age,
      'Description':description,
      'video_url':videoUrl,
    };
  }
}
