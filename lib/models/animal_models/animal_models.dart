import 'package:animals/core/enum/animals_categpry_enum.dart';
import 'package:intl/intl.dart';
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
  final String price;
  final String sellerId;
  final AnimalsCategoryEnum category;
  final String name;
  final PetMetadata metadata;
  final List<Media> images;
  final String location;
  final List<String> impressions;
  final List<String> wishList;
  final String phone;
  final String whatsapp;
  final String description;
  final String ? videoUrl;
  final String sellerName;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  AnimalModels({
    required this.wishList,
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
    required this.price,
    this.videoUrl,
    required this.sellerName,
    this.createdAt,
    this.updatedAt,

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
      sellerName: json['Seller_name'],
        wishList: List<String>.from(json['WishList'] ?? []),
      price: json['Price'],
      sellerId: json['seller_id'],
        category: AnimalsCategoryEnum.values.firstWhere(
              (e) => e.toString() == 'PetType.${json['category']}',
          orElse: () => AnimalsCategoryEnum.dogs,  // Default to 'dogs' if no match
        ),
      name: json['name'],
      metadata: metadata,
      images: images,
      location: json['location'],
      impressions: List<String>.from(json['impression'] ?? []),
      phone: json['Phone'],
      whatsapp: json['whatsApp'], gender: GenderEnum.values.firstWhere((e) => e.toString().split('.').last == json['Gender'],),
      age: json['Age'],
      description: json['Description'],
      videoUrl:  json['video_url'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Seller_name': sellerName,
      'seller_id': sellerId,
      'category': category.toString().split('.').last,
      'name': name,
      'metadata': metadata.toJson(),
      'images': images.map((image) => image.toJson()).toList(),
      'location': location,
      'impression': impressions,
      'Phone': phone,
      'whatsApp': whatsapp,
      'Gender': gender.toString().split('.').last,
      'Age': age,
      'Description': description,
      'video_url': videoUrl ?? '',
      'Price': price,
      'WishList': wishList,
    };

    // Format DateTime to match 'yyyy-MM-dd HH:mm:ss.SSSSSS+00'
    final DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");
    // If createdAt is not null, format it and add to the map
    if (createdAt != null) {
      data['created_at'] = '${formatter.format(createdAt!.toUtc())}+00';
    }
    // If updatedAt is not null, format it and add to the map
    if (updatedAt != null) {
      data['updated_at'] = '${formatter.format(updatedAt!.toUtc())}+00';
    }
    return data;
  }
}
