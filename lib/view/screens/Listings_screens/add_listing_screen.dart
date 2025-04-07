import 'package:animals/providers/Listing_provider/add_listing_provider.dart';
import 'package:animals/view/common/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/enum/animals_categpry_enum.dart';
import '../../../core/utils/helper_fuctions/format_validator.dart';
import '../../common/vedio_player.dart';

class AddListingScreen extends ConsumerWidget {
  const AddListingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watchProvider = ref.watch(addListingProvider.notifier);
    var state = ref.watch(addListingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Listing"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title input
              CustomTextField(
                controller: watchProvider.nameController,
                hintText: 'Title',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Title');
                },
              ),

              // Age input
              CustomTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: watchProvider.ageController,
                hintText: 'Age in months',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Age in months');
                },
              ),

              CustomTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                controller: watchProvider.priceController,
                hintText: 'Price',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Price');
                },
              ),

              // Location input
              CustomTextField(
                controller: watchProvider.locationController,
                hintText: 'Location',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Location');
                },
              ),

              // Phone input
              CustomTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                controller: watchProvider.phoneController,
                hintText: 'Phone',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Phone');
                },
              ),



              // WhatsApp input
              CustomTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                controller: watchProvider.whatsappController,
                hintText: 'WhatsApp',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'WhatsApp');
                },
              ),

              //  Description input
              CustomTextField(
                maxLine: 4,
                controller: watchProvider.descriptionsController,
                hintText: 'Description',
                validate: (value) {
                  return FormValidators.validateNormalField(value, 'Description');
                },
              ),

              // Animal Category Dropdown
              DropdownButtonFormField<GenderEnum>(
                value: state.gender,
                onChanged: (newGender) {
                  if (newGender!= null) {
                    watchProvider.state = watchProvider.state.copyWith(gender: newGender);
                  }
                },
                items: GenderEnum.values.map((GenderEnum gender) {
                  return DropdownMenuItem<GenderEnum>(
                    value: gender,
                    child: Text(gender.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select Gender Category'),
              ),

              // Animal Category Dropdown
              DropdownButtonFormField<AnimalsCategoryEnum>(
                value: state.category,
                onChanged: (newCategory) {
                  if (newCategory != null) {
                    watchProvider.state = watchProvider.state.copyWith(category: newCategory);
                  }
                },
                items: AnimalsCategoryEnum.values.map((AnimalsCategoryEnum category) {
                  return DropdownMenuItem<AnimalsCategoryEnum>(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select Animal Category'),
              ),

              // Display specific fields based on category
              if (state.category == AnimalsCategoryEnum.dogs) ...[
                CustomTextField(controller: watchProvider.breedController, hintText: 'Breed',validate: (value){}),
                CustomTextField(controller: watchProvider.sizeController, hintText: 'Size',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.cats) ...[
                CustomTextField(controller: watchProvider.breedController, hintText: 'Breed',validate: (value){}),
                CustomTextField(controller: watchProvider.colorController, hintText: 'Color',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.birds) ...[
                CustomTextField(controller: watchProvider.speciesController, hintText: 'Species',validate: (value){}),
                CustomTextField(controller: watchProvider.wingspanController, hintText: 'Wingspan',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.goats) ...[
                CustomTextField(controller: watchProvider.breedController, hintText: 'Breed',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.chickens) ...[
                CustomTextField(controller: watchProvider.breedController, hintText: 'Breed',validate: (value){}),
                CustomTextField(controller: watchProvider.colorController, hintText: 'Color',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.cows) ...[
                CustomTextField(controller: watchProvider.milkProductionController, hintText: 'Milk Production',validate: (value){}),
                CustomTextField(controller: watchProvider.breedController, hintText: 'Breed',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.sheep) ...[
                CustomTextField(controller: watchProvider.breedController, hintText: 'Breed',validate: (value){}),
              ],
              if (state.category == AnimalsCategoryEnum.others) ...[
                CustomTextField(controller: watchProvider.otherDescriptionController, hintText: 'Description',validate: (value){}),
              ],

              // Metadata Checkboxes
              if (state.category == AnimalsCategoryEnum.dogs || state.category == AnimalsCategoryEnum.cows) ...[
                Row(
                  children: [
                    Checkbox(
                      value: state.isVaccinated,
                      onChanged: (bool? newValue) {
                        watchProvider.state = watchProvider.state.copyWith(isVaccinated: newValue ?? false);
                      },
                    ),
                    Text("Vaccinated"),
                  ],
                ),
              ],
              if (state.category == AnimalsCategoryEnum.goats || state.category == AnimalsCategoryEnum.cows) ...[
                Row(
                  children: [
                    Checkbox(
                      value: state.isPregnant,
                      onChanged: (bool? newValue) {
                        watchProvider.state = watchProvider.state.copyWith(isPregnant: newValue ?? false);
                      },
                    ),
                    Text("Pregnant"),
                  ],
                ),
              ],
              if (state.category == AnimalsCategoryEnum.chickens) ...[
                Row(
                  children: [
                    Checkbox(
                      value: state.laysEggs,
                      onChanged: (bool? newValue) {
                        watchProvider.state = watchProvider.state.copyWith(laysEggs: newValue ?? false);
                      },
                    ),
                    Text("Lays Eggs"),
                  ],
                ),
              ],
              if (state.category == AnimalsCategoryEnum.sheep) ...[
                Row(
                  children: [
                    Checkbox(
                      value: state.woolProduction,
                      onChanged: (bool? newValue) {
                        watchProvider.state = watchProvider.state.copyWith(woolProduction: newValue ?? false);
                      },
                    ),
                    Text("Wool Production"),
                  ],
                ),
              ],

              // Image Upload Section
              ElevatedButton(
                onPressed: () async {
                  await watchProvider.requestAndPickImages(context: context);
                },
                child: Text("Pick Images"),
              ),
              if (state.images != null && state.images!.isNotEmpty) ...[
                Text("Selected Images:"),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: state.images!.length,
                  itemBuilder: (context, index) {
                    return Image.file(state.images![index], fit: BoxFit.cover);
                  },
                ),
              ],

              // Video Upload Section
              ElevatedButton(
                onPressed: () async {
                  await watchProvider.pickVideo(context: context);
                },
                child: Text("Pick Video"),
              ),
              if (state.video != null) ...[
                SizedBox(height: 10),
                Text("Selected Video:"),
                Container(
                  width: 100,
                  height: 100,
                  child: VideoThumbnail(source: state.video!),
                ),
              ],
              ElevatedButton(
                onPressed: () async {
                  await watchProvider.uploadAndStoreImages(
                    context: context,
                    images: state.images!,
                    video: state.video!,
                  );
                },
                child: state.isLoading ? CircularProgressIndicator() : Text("Submit Listing"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

