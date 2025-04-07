import 'dart:io';
import 'package:animals/core/constants/app_constant/app_constant.dart';
import 'package:animals/core/enum/animals_categpry_enum.dart';
import 'package:animals/models/image_model/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Repository/Listing_repo/add_listing_repo.dart';
import '../../core/exceptions/net_work_excptions.dart';
import '../../core/utils/helper_fuctions/helper_function.dart';
import '../../models/animal_models/animal_models.dart';
import '../../models/meta_manger/metaData_manger.dart';


final addListingProvider = StateNotifierProvider<AddListingNotifier,AddListingState>((ref){
  return AddListingNotifier();
});

class AddListingNotifier extends StateNotifier<AddListingState> {
  AddListingNotifier() :super(AddListingState(isLoading: false,
      category: AnimalsCategoryEnum.dogs,
      images: null,
      gender: GenderEnum.male,
      video: null,
      isVaccinated: false,
      isPregnant: false,
      laysEggs: false,
      woolProduction: false));

  // Common fields

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController descriptionsController = TextEditingController();


  // Add controllers for category-specific metadata

  TextEditingController breedController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController wingspanController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController milkProductionController = TextEditingController();
  TextEditingController tankSizeController = TextEditingController();
  TextEditingController waterTypeController = TextEditingController();
  TextEditingController otherDescriptionController = TextEditingController();


  Future<void> requestAndPickImages({required BuildContext context}) async {
    try {
      List<File> images = await HelperFunctions.pickMultipleImages(
          context: context);
      state = state.copyWith(images: images);
    } catch (error) {
      ExceptionHandler.handle(error, context);
    }
  }

  Future<void> pickVideo({required BuildContext context}) async {
    try {
      File ? video = await HelperFunctions.pickShortVideo(context: context,);
      state = state.copyWith(video: video);
    } catch (error) {
      ExceptionHandler.handle(error, context);
    }
  }

  void removeImage({required int index}) {
    if (state.images != null && index >= 0 && index < state.images!.length) {
      List<File> updatedImages = List.from(state.images!);
      updatedImages.removeAt(index);
      state = state.copyWith(images: updatedImages);
    }
  }

  PetMetadata get metadata {
    final metadataManager = MetadataManager(
      breedController: breedController,
      sizeController: sizeController,
      colorController: colorController,
      speciesController: speciesController,
      wingspanController: wingspanController,
      milkProductionController: milkProductionController,
      tankSizeController: tankSizeController,
      waterTypeController: waterTypeController,
      otherDescriptionController: otherDescriptionController,
      isVaccinated: state.isVaccinated,
      isPregnant: state.isPregnant,
      laysEggs: state.laysEggs,
      woolProduction: state.woolProduction,
    );
    return metadataManager.getMetadata(state.category);
  }


  Future<void> uploadAndStoreImages({
    required BuildContext context,
    required List<File> images,
    required File video,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      if (images.isEmpty) {
        state = state.copyWith(isLoading: false);
        ExceptionHandler.handle('No image selected', context);
        return;
      }
      // Upload video first
      String? videoUrl;
      videoUrl = await AddListingRepo.uploadVideo(context: context, video: video);
      // Upload images
      List<Media> uploadedImages = await AddListingRepo.uploadImages(context: context, images: images);
      // Check if any images were uploaded
      if (uploadedImages.isNotEmpty) {
        // Prepare the AnimalModels object with metadata and uploaded media
        AnimalModels highlights = AnimalModels(
          age: ageController.text.toString(),
          gender: state.gender!,
          sellerId: AppConstants.currentUser!.id,
          category: state.category,
          name: nameController.text.toString(),
          metadata: metadata,
          images: uploadedImages,
          location: locationController.text.toString(),
          impressions: [],
          phone: phoneController.text.toString(),
          whatsapp: whatsappController.text.toString(),
          description: descriptionsController.text.toString(),
          videoUrl: videoUrl.toString(),
        );
        // Insert data into SupaBase
        await AddListingRepo.insertDataToSupaBase(context: context, highlights: highlights);
      } else {
        ExceptionHandler.handle('No images were uploaded', context);
      }
      state = state.copyWith(isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      ExceptionHandler.handle(error, context);
    }

  }

}

class AddListingState {
  final bool isLoading;
  final AnimalsCategoryEnum category;
  final List<File> ? images ;
  final GenderEnum ? gender;
  final File ? video;
  final bool isVaccinated ;
  final bool isPregnant ;
  final bool laysEggs;
  final bool woolProduction ;
  AddListingState({required this.isLoading,required this.category,required this.images,required this.gender,required this.video,required this.isPregnant,required this.isVaccinated,required this.laysEggs,required this.woolProduction});
  AddListingState copyWith({bool ?isLoading,AnimalsCategoryEnum ? category,List<File> ? images,GenderEnum ? gender,File ? video, bool ? isVaccinated,bool ? isPregnant,bool ?laysEggs, bool ? woolProduction}){
   return AddListingState(isLoading: isLoading ?? this.isLoading ,category: category ?? this.category,images: images ?? this.images,gender: gender ?? this.gender,video: video ?? this.video,isPregnant: isPregnant ?? this.isPregnant,isVaccinated: isVaccinated ?? this.isVaccinated,laysEggs: laysEggs ?? this.laysEggs,woolProduction: woolProduction ?? this.woolProduction);
  }
}